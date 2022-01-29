
$:.unshift File.expand_path(File.dirname(__FILE__), '../')

require 'app'
run Sinatra::Application

#* You want to deploy with a different Rack handler (Passenger, Unicorn,  Heroku, ...).
#* You want to use more than one subclass of `Sinatra::Base`.
#* You want to use Sinatra only for middleware, and not as an endpoint.
