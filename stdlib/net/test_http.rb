
require 'net/http'

Net::HTTP.get('example.com', '/index.html')


# get by uri
uri = URI('http://example.com/index.html?count=10')
Net::HTTP.get(uri)

# get with dynamic parameters
uri = URI('http://example.com/index.html')
params = {:limit => 10, :page => 3}
uri.query = URI.encode_www_form(params)

res = Net::HTTP.get_response(uri)
puts res.body if res.is_a?(Net::HTTPSuccess)


#POST
uri = URI('http://www.example.com/search.cgi')
res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max'=> '50')
puts res.body

## post with 
uri = URI('http://www.example.com/search.cgi')
res = Net::HTTP.post_form(uri, 'q'=> ['ruby', 'perf'], 'max'=> '50')
puts res.body


# how to use Net::HTTP

uri = URI('http://example.com/index.html?query=xxx')
Net::HTTP.start(uri.host, uri.port) do |http|
  request = Net::HTTP::Get.new uri
  response = http.request request   # Net::HTTPResponse. object
  puts response
end


# response data

uri = URI('http://example.com/index.html')
res = Net::HTTP.get_response(uri)

#header
res['Set-Cookie'] 
res.get_fields('set-cookie')
res.to_hash['set-cookie']
puts "Headers: #{res.to_hash.inspect}"
require 'awesome_print'
ap res.to_hash

# status
puts res.code
puts res.message
puts res.class.name


# body
puts res.body if res.response_body_permitted?
puts res.body


# follow redirection
def fetch(uri_str, limit = 10)
  # you should choose a better exception
  raise ArgumentError, 'too many HTTP redirects' if limit == 0
  response = Net::HTTP.get_response(URI(uri_str))

  case response
      when Net::HTTPSuccess then
        response
      when Net::HTTPRedirection then
        location = response['location']
        warn "redirected to #{location}"
        fetch(location, limit - 1)
      else
        response.value
  end
end

print fetch('http://www.ruby-lang.org')
print fetch('http://baidu.com')



# POST
uri = URI('http://www.example.com/todo.cgi')
req = Net::HTTP::Post.new(uri)
req.set_form_data('from'=>'2005-01-01', 'to' => '2005-03-31')

res = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(req)
end

case res
when Net::HTTPSuccess, Net::HTTPRedirection 
  puts res
else
  puts res.value
end



# not mutlpart/part support, use #body=, #content_type=
req = Net::HTTP::Post.new(uri)
req.body = multipart_data
req.content_type = 'multipart/form-data'


# Setting headers


# Basic Authentication



# Streaming Respones Bodies



# HTTPS


# Proxies
proxy_addr = 'venus'
proxy_port = 8123

Net::HTTP.new('example.com', nil, proxy_addr, proxy_port).start {|http|
  request = Net::HTTP::Get.new '/index.html'
  resp =  http.request  request
  puts resp,resp.body
}


# Compression



# HTTP Request Classes
  # * Net::HTTPRequest
  #   * Net::HTTP::Get
  #   * Net::HTTP::Head
  #   * Net::HTTP::Post
  #   * Net::HTTP::Patch
  #   * Net::HTTP::Put
  #   * Net::HTTP::Proppatch
  #   * Net::HTTP::Lock
  #   * Net::HTTP::Unlock
  #   * Net::HTTP::Options
  #   * Net::HTTP::Propfind
  #   * Net::HTTP::Delete
  #   * Net::HTTP::Move
  #   * Net::HTTP::Copy
  #   * Net::HTTP::Mkcol
  #   * Net::HTTP::Trace



# HTTPResponesClass
  # == HTTP Response Classes
  #
  # Here is HTTP response class hierarchy.  All classes are defined in Net
  # module and are subclasses of Net::HTTPResponse.
  #
  # HTTPUnknownResponse:: For unhandled HTTP extensions
  # HTTPInformation::                    1xx
  #   HTTPContinue::                        100
  #   HTTPSwitchProtocol::                  101
  # HTTPSuccess::                        2xx
  #   HTTPOK::                              200
  #   HTTPCreated::                         201
  #   HTTPAccepted::                        202
  #   HTTPNonAuthoritativeInformation::     203
  #   HTTPNoContent::                       204
  #   HTTPResetContent::                    205
  #   HTTPPartialContent::                  206
  #   HTTPMultiStatus::                     207
  #   HTTPIMUsed::                          226
  # HTTPRedirection::                    3xx
  #   HTTPMultipleChoices::                 300
  #   HTTPMovedPermanently::                301
  #   HTTPFound::                           302
  #   HTTPSeeOther::                        303
  #   HTTPNotModified::                     304
  #   HTTPUseProxy::                        305
  #   HTTPTemporaryRedirect::               307
  # HTTPClientError::                    4xx
  #   HTTPBadRequest::                      400
  #   HTTPUnauthorized::                    401
  #   HTTPPaymentRequired::                 402
  #   HTTPForbidden::                       403
  #   HTTPNotFound::                        404
  #   HTTPMethodNotAllowed::                405
  #   HTTPNotAcceptable::                   406
  #   HTTPProxyAuthenticationRequired::     407
  #   HTTPRequestTimeOut::                  408
  #   HTTPConflict::                        409
  #   HTTPGone::                            410
  #   HTTPLengthRequired::                  411
  #   HTTPPreconditionFailed::              412
  #   HTTPRequestEntityTooLarge::           413
  #   HTTPRequestURITooLong::               414
  #   HTTPUnsupportedMediaType::            415
  #   HTTPRequestedRangeNotSatisfiable::    416
  #   HTTPExpectationFailed::               417
  #   HTTPUnprocessableEntity::             422
  #   HTTPLocked::                          423
  #   HTTPFailedDependency::                424
  #   HTTPUpgradeRequired::                 426
  #   HTTPPreconditionRequired::            428
  #   HTTPTooManyRequests::                 429
  #   HTTPRequestHeaderFieldsTooLarge::     431
  # HTTPServerError::                    5xx
  #   HTTPInternalServerError::             500
  #   HTTPNotImplemented::                  501
  #   HTTPBadGateway::                      502
  #   HTTPServiceUnavailable::              503
  #   HTTPGatewayTimeOut::                  504
  #   HTTPVersionNotSupported::             505
  #   HTTPInsufficientStorage::             507
  #   HTTPNetworkAuthenticationRequired::   511
  #


