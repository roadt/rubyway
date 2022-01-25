require 'net/http'
require 'net/http/post/multipart'
#require 'net/http/post/composite_io'


uri = URI('http://httpbin.org/post')
File.open(__FILE__) do |file|
  req = Net::HTTP::Post::Multipart.new uri.path,
                                       file: UploadIO.new(file, "text/plain", "xxx.txt")
  res = Net::HTTP.start(uri.host, uri.port) do |http|
    http.request req
  end
  puts res.body
end


require 'restclient/core'

