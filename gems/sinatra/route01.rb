require 'sinatra'

# normal
get '/hello/:name' do
  #matches "GET /hello/foo" and "GET /hello/bar"
  # params[:name] is 'foo' or 'bar'
  "Hello #{params[:name]}"
end


get '/hello2/:name' do |n|
  "Hello2 #{n}"
end


# route may include spliats (or wildcard), accessiable via 
# the params[:splat]  or with bllck parameter
get '/say/*/to/*' do
  # matches /say/hello/to/world
  params[:splat] # => ["hello, world"]
end

get '/download/*.*' do |path, ext|
  [path, ext]  # => ["path/to/file", "xml"]
end

# route matches with Regex
get %r{/hello3/([\w]+)} do
  "Helllo, #{params[:captures].first}! (regex-captures-access)>"
end

get %r{/hello4/([\w]+)} do |c|
  "Hello, #{c}!  (regex-block-access)"
end

# route - option parameters

get '/posts.?:format?' do
  # matches  'GET /posts" and any extension "GET /posts.json", "GET /posts.xml" etc.
end


# Conditions


get '/foo', :agent => /Songbird (\d\.\d)[\d\/]*?/ do
  "You're using Songbird version #{params[:agent][0]}"
end

get '/foo' do
  # Matches non-songbird browsers
  "You're using Non-Songbird browsers"
end

# other available conditions are `host_name` and `provides`:

get '/', :host_name => /^admin\./ do
  "Admin Area, Access denied!"
end

get '/', :provides => 'html' do
  haml :index
end

get '/', :provides => ['rss', 'atom', 'xml'] do
  builder :feed
end


# you can easily define your own conditions:

set(:probability) { |value| condition { rand <= value } }

get '/win_a_car', :probability => 0.1 do
  "You won!"
end

get '/win_a_car' do
  "Sorry, you lost."
end

