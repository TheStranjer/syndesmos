class Syndesmos
  GENERIC_GETS = [
    "/api/pleroma/emoji",
    "/api/pleroma/captcha",
    "/api/v1/timelines/home",
    "/api/v1/timelines/direct",
    "/api/v1/timelines/public",
    "/api/v1/notifications"
  ]

  GENERIC_GETS.each do |get|
    define_method(get.split('/').last.to_sym) do |params = {}|
      req(path: get, http_method: :get, params: params)
    end
  end

  GENERIC_POSTS = [
    "/api/v1/statuses/$ID/favourite",
    "/api/v1/statuses/$ID/unfavourite",
    "/api/v1/statuses/$ID/reblog",
    "/api/v1/statuses/$ID/unreblog",
    "/api/v1/statuses/$ID/follow",
    "/api/v1/statuses/$ID/unfollow",
    "/api/v1/pleroma/accounts/$ID/unsubscribe",
    "/api/v1/statuses"
  ]

  GENERIC_POSTS.each do |post|
    meth_name = post.split('/').last.to_sym
    if post.include?("$ID")
      define_method(meth_name) do |id, params={}|
        req(path: post.gsub("$ID", id), http_method: :post, params: params)
      end
    else
      define_method(meth_name) do |params={}|
        req(path: post, http_method: :post, params: params)
      end
    end
  end
end