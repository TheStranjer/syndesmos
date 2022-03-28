require 'net/http'
require 'json'
require_relative 'generics'
require_relative 'login'
require_relative 'media'
require_relative 'hooks'

class Syndesmos
  attr_reader :bearer_token, :username, :password, :instance, :api

  def initialize(bearer_token: nil, username: nil, password: nil, instance:, api: Net::HTTP)
    @instance = instance
    @api = api
    @hooks = {}
    if bearer_token
      @bearer_token = bearer_token
    elsif username and password
      callback = req(path: "/api/v1/apps", http_method: :post, params: { 'client_name' => 'Syndesmos', 'redirect_uris' => "https://#{instance}/oauth-callback", 'scopes' => 'read write follow push admin' })
      login = req(path: "/oauth/token", http_method: :post, params: { 'username' => username, 'password' => password, 'client_id' => callback['client_id'], 'client_secret' => callback['client_secret'], 'grant_type' => 'password' })
      @bearer_token = login['access_token']
    end

    Thread.new { execute_hooks }
  end

  private

  attr_accessor :hooks

  def req(path:, http_method: :get, params: {})
    url = "https://#{instance}#{path}" 
    url += "?" + params.reject { |k,v| v.nil? }.collect {|k,v| "#{k}=#{v}" }.join('&' ) if http_method == :get and params.length > 0
    uri = URI.parse(url)

    header = { 'Content-Type': 'application/json' }
    header['Authorization'] = "Bearer #{bearer_token}" if bearer_token

    http = api.new(uri.host, uri.port)
    http.use_ssl = true

    req = http_method_obj(http_method).new(uri.request_uri, header)
    req.body = params.to_json if http_method != :get

    res = http.request(req)

    JSON.parse(res.body)
  end

  def http_method_obj(sym)
    case sym
    when :get
      api::Get
    when :post
      api::Post
    when :patch
      api::Patch
    when :delete
      api::Delete
    end
  end
end
