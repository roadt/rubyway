
require 'sinatra'
require 'yaml'

get '/' do 
  self
end

get '/a/:name/:value' do |a, p|
  [a,p].to_s + params.to_s
end

get '/b/*/to/*' do 
  params.to_s
end

get %r{/hello/([\w]+)} do
  params.to_s
end

post '/' do
  'Post data'
end

put '/' do
  'this is Put'
end

options '/' do
  'Option, you support? Wow'
end



get '/env' do
  raise env
end


get '/test01/*.*/:name' do  |path,ext, name|
  "#{[path, ext, name]}  #{params}"
end
  
