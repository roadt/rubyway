
require 'net/http'

def fetch(uri_str, limit = 10)
  raise ArgumentError, 'too many HTTP redirects' if limit == 0
  resp = Net::HTTP.get_response(URI(uri_str))

  case resp
    when Net::HTTPSuccess then
    resp
    when Net::HTTPRedirection then
    location = resp['location']
    warn "redirected to #{location}"
    fetch(location, limit - 1)
  else
    resp.value
  end
end

