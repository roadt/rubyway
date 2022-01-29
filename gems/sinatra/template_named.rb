require 'sinatra'

template :layout do
  "%html\n = yield\n"
end

template :index do
  '%div.title Hello World!'
end

get '/' do
  haml :index
end

