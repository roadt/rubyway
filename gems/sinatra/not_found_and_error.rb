
require 'sinatra'

not_found do
  'This is nowhere to be found'
end

error do 
  'Sorry there was a nasty error  -' + env['sinatra.error'].name
end

class MyCustomError < StandardError
end

error MyCustomError do
  'So what happend aas ...' + env['sinatra.error'].message
end

# 403
error 403 do
  '<h1>Access  forbidden'
end

# or status range
error 404..510 do
  'Boom'
end


get '/' do 
  raise  MyCustomError, 'something bad'
end

get '/secret' do
  403
end


get '/fail' do
  500
end
