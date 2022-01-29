
require 'sinatra'

get '/' do 
  'Hello world!'
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

