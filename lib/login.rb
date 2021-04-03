class Syndesmos
  def valid_credentials?
    attempt = req(path: "/api/v1/accounts/verify_credentials")
    attempt.class == Hash and attempt.keys.include?('acct') and not attempt.keys.include?("error")
  end
end