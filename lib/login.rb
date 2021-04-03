class Syndesmos
  def valid_credentials?
    attempt = req(path: "/api/v1/accounts/verify_credentials")
    bearer_token.to_s.length > 0 and attempt.class == Hash and attempt.keys.include?('acct') and not attempt.keys.include?("error")
  end
end