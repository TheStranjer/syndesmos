class Syndesmos
  def media(filename)
    uri = URI.parse("https://#{instance}/api/v1/media")
    header = {'Authorization': "Bearer #{bearer_token}"}

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Post.new(uri.request_uri)
    req['Authorization'] = "Bearer #{bearer_token}"
    req.set_form({"file" => File.open(filename)}, "multipart/form-data")

    res = http.request(req)

    JSON.parse(res.body)
  end
end