class Syndesmos
  def valid_credentials?
    attempt = verify_credentials
    bearer_token.to_s.length > 0 and attempt.class == Hash and attempt.keys.include?('acct') and not attempt.keys.include?("error")
  end
end