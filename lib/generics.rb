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
    "/api/v1/accounts/verify_credentials",
    "/api/v1/accounts/$ID/following",
    "/api/v1/accounts/$ID/followers",
    "/api/v1/pleroma/accounts/$ID/scrobbles",
    "/api/v1/accounts/$ID/statuses",
    "/api/v1/instance/peers",
    "/api/v1/pleroma/admin/relay"
  ]

  GENERIC_POSTS = [
    "/api/v1/statuses/$ID/favourite",
    "/api/v1/statuses/$ID/unfavourite",
    "/api/v1/statuses/$ID/reblog",
    "/api/v1/statuses/$ID/unreblog",
    "/api/v1/accounts/$ID/follow",
    "/api/v1/accounts/$ID/unfollow",
    "/api/v1/pleroma/accounts/$ID/unsubscribe",
    "/api/v1/statuses",
    "/api/v1/pleroma/scrobble",
    "/api/v1/pleroma/admin/relay"
  ]

  GENERIC_PATCHES = [
    "/api/v1/accounts/update_credentials"
  ]

  GENERIC_DELETES = [
    "/api/v1/scheduled_statuses/$ID"
  ]

  GENERIC_TYPES = {:patch => GENERIC_PATCHES, :get => GENERIC_GETS, :post => GENERIC_POSTS, :delete => GENERIC_DELETES}

  def self.meth_name_end(path)
      path.split('/').last.to_sym
  end

  def self.generic_name(path, http_method)
    if GENERIC_TYPES.select { |http_method, actions| actions.collect { |action| Syndesmos.meth_name_end(action) }.include?(Syndesmos.meth_name_end(path)) }.length > 1
      "#{http_method}_#{path.split('/').last}".to_sym
    else
      Syndesmos.meth_name_end(path)
    end
  end

  GENERIC_TYPES.each do |http_method, actions|
    actions.each do |action|
      meth_name = Syndesmos.generic_name(action, http_method)
      if action.include?("$ID")
        define_method(meth_name) do |id, params={}|
          req(path: action.gsub("$ID", id), http_method: http_method, params: params)
        end
      else
        define_method(meth_name) do |params={}|
          req(path: action, http_method: http_method, params: params)
        end
      end
    end
  end

end
