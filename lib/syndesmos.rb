require 'net/http'
require 'json'

class Syndesmos
  attr_reader :bearer_token, :username, :password, :instance, :api

  def initialize(bearer_token: nil, username: nil, password: nil, instance:, api: Net::HTTP)
    @instance = instance
    @api = api
    if bearer_token
      @bearer_token = bearer_token
    elsif username and password

    end
  end

  private

  def req(path:, http_method: :get, params: {})
    uri = URI.parse("https://#{instance}#{path}")

    header = { 'Content-Type': 'application/json' }
    header['Authorization'] = "Bearer #{bearer_token}" if bearer_token

    http = api.new(uri.host, uri.port)
    http.use_ssl = true

    req = http_method_obj(http_method).new(uri.request_uri, header)
    req.body = params.to_json

    res = http.request(req)

    JSON.parse(res.body)
  end

  def http_method_obj(sym)
    case sym
    when :get
      api::Get
    when :post
      api::Post
    end
  end
end