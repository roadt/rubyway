
require 'sinatra/base'
my_app = Sinatra.new { get('/') { "hi"} }
print my_app
my_app.run!
