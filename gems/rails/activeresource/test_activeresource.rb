
#gem 'activeresource', '3.2.13'
gem 'activeresource'
require 'active_resource'

class Post < ActiveResource::Base
  self.site = "https://httpbin.org"
  self.format = :json
end

class Comment < ActiveResource::Base
  self.site = "https://httpbin.org"
  self.format = :json

end


require 'pp'
pp Post.instance_methods
