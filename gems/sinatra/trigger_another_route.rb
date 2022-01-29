
require 'sinatra'

get '/foo' do
  status, headers, body = call env.merge('PATH_INFO'=>'/bar')
  [status, headers, body.map(&:upcase)]
end

get '/bar' do
  'bar'
end

# use call!  can be send request to same instance.
# call create a new instance and trigger/deliver request

