
r =  '~>3.2.13'
gem 'actionpack',r
gem 'actionview', r

require 'active_support/all'
require 'action_view'

class View < ActionView::Base
  def url_for(options)
  end
end


v = View.new
v.label_tag 'xxxx'




gem 'activemodel', r
require 'active_model'
class M 
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  
  attr_accessor :a, :b

  def persisted?
    false
  end
end




# way1:  set url: 'xxxx'  so that  form_form not query url from route engine using model object/class
v.form_for M.new, url:'aaa', method: 'get' do |f|
  # only formhelper#methods stuff valid

  f.label 'xxx'
  puts f.field_helpers
end


# post - nened authentication token stuff
v.form_for M.new, url:'aaa', method: 'get' do |f|
  f.label 'xxx'
  puts f.field_helpers
end


# way2, fill right to route engine
ActionDispatch::Routing::RouteSet.draw do
  resources :m
end
v.form_for M.new do |f|
  
end
