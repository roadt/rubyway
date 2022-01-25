

# require
require 'uri'
require 'pp'
require 'awesome_print'

## basic usage
uri = URI('http://foo.com/posts?id=30&limit=5#time=1305298413')
pp [uri.scheme,uri.host,uri.port,uri.path,uri.query,uri.fragment]


## custom
module URI
  class RSYNC < Generic
    DEFAULT_PORT =  873
  end
  @@schemes["RSYNC"]  = RSYNC
end

pp URI.scheme_list
pp uri = URI("rsync://rsync.foo.com")
pp [uri.scheme,uri.host, uri.port,uri.path,uri.query,uri.fragment]


#
