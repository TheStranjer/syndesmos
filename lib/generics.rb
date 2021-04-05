class Syndesmos
  GENERIC_GETS = [
    "/api/pleroma/emoji",
    "/api/pleroma/captcha",
    "/api/v1/timelines/home",
    "/api/v1/timelines/direct",
    "/api/v1/timelines/public",
    "/api/v1/notifications",
    "/api/pleroma/admin/relay",
    "/api/v1/instance/peers",
    "/api/v1/accounts/verify_credentials"
  ]

  GENERIC_POSTS = [
    "/api/v1/statuses/$ID/favourite",
    "/api/v1/statuses/$ID/unfavourite",
    "/api/v1/statuses/$ID/reblog",
    "/api/v1/statuses/$ID/unreblog",
    "/api/v1/statuses/$ID/follow",
    "/api/v1/statuses/$ID/unfollow",
    "/api/v1/pleroma/accounts/$ID/unsubscribe",
    "/api/v1/statuses",
    "/api/pleroma/admin/relay"
  ]

  GENERIC_PATCHES = [
    "/api/v1/accounts/update_credentials"
  ]

  GENERIC_TYPES = [GENERIC_PATCHES, GENERIC_GETS, GENERIC_POSTS]

  def self.generic_name(path, http_method)
    if GENERIC_TYPES.select { |http_method| http_method.include?(path) }.length > 1
      "#{http_method}_#{path.split('/').last}".to_sym
    else
      path.split('/').last.to_sym
    end
  end

  GENERIC_GETS.each do |get|
    define_method(Syndesmos.generic_name(get, :get)) do |params = {}|
      req(path: get, http_method: :get, params: params)
    end
  end

  GENERIC_POSTS.each do |post|
    meth_name = Syndesmos.generic_name(post, :post)
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

  GENERIC_PATCHES.each do |patch|
    define_method(Syndesmos.generic_name(patch, :patch)) do |params = {}|
      req(path: patch, http_method: :patch, params: params)
    end
  end
end