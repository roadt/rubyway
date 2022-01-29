require 'sinatra'

get '/', :agent => /Songbird/ do
  "You're using Songbird!"
end

get '/' do
  "Hello World"
end


get '/hello' do
  "Hello #{params[:name]}!"
end

get '/hello/:name' do 
  "Hello #{params[:name]}!"
end

get '/hello2/:name' do |n|
  "Hello #{n}!"
end

# splat
get '/say/*/to/*' do 
  params[:splat] #  /say/hello/to/world => ["hello", "world"]
end

get '/download/*.*' do 
  params[:splat]  #  ['path/to/file', 'xml']  from matches '/download/path/to/file.xml'
end

#block param
get '/download2/*.*' do |path, ext|
  [path, ext] # => ['path/to/file', 'xml']
end

#regex
get %r{/hello3/([\w]+)} do
  "Hello, #{params[:captures].first}!"
end

#block regex
get %r{/hello4/([\w]+)} do |c|
  "Hello, #{c}!"
end


#optioal param
get '/posts.?:format?' do
  # match "GET /posts" and any extension "GET /posts.json", "GET /posts.xml" etc.
  params
end
