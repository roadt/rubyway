

require 'sinatra'


# semantics of `use` are identical to those in Rack::Buildler
use Rack::Lint

get '/hello' do 
  'Hello World'
end
