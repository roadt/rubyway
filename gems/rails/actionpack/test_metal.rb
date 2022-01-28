

gem 'actionpack', '~>3.0'
require 'action_controller'


  
class MyMetal < ActionController::Metal
  
end


Rack::Handler.default.run MyMetal, :Port=>9292
