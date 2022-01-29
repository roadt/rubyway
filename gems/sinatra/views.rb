

require 'sinatra'


# this render views/index.rb
get '/' do
  erb :index
end

get '/0' do 
  code = "<%= Time.now %>"
  erb code
end

# render 'views/index.erb. embbed in 'views/posts.erb'.(def is 'views'layouterb')
get '/1' do 
  erb :index, :layout=> :post
end

set :public_folder, File.dirname(__FILE__) + '/static'

get '/2' do
  haml :index, :format => :html5
end


# set option on template lang type in general
set :haml, :format => :html5

get '/3' do 
  haml :index
end


# all options 
# locals
# default_encoding
# views
# layout
# content_type
# scope
# layout_engine
# layout_options

=begin
locals
    List of locals passed to the document. Handy with partials. Example: erb "
    <%= foo %>", :locals => {:foo => "bar"}
default_encoding
    String encoding to use if uncertain. Defaults to
    settings.default_encoding.
views
    Views folder to load templates from. Defaults to settings.views.
layout
    Whether to use a layout (true or false), if it's a Symbol, specifies what
    template to use. Example: erb :index, :layout => !request.xhr?
content_type
    Content-Type the template produces, default depends on template language.
scope
    Scope to render template under. Defaults to the application instance. If
    you change this, instance variables and helper methods will not be
    available.
layout_engine
    Template engine to use for rendering the layout. Useful for languages that
    do not support layouts otherwise. Defaults to the engine used for the
    template. Example: set :rdoc, :layout_engine => :erb
layout_options
    Special options only used for rendering the layout. Example: set :rdoc,
    :layout_options => { :views => 'views/layouts' }

=end


get '/4' do 
  erb '<%= foo %>', :locals => {:foo => 'bar' }
end

