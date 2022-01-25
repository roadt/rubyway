require 'pp'


class Mapper
  def initialize
  end

  def draw
    yield self
  end

  def resources
  end

  def resource
  end

  def get
  end


end



class RouteSet
  attr_accessor :routes
  def initialize 
    @routes = []
  end
  def routes
    @routes
  end
  def request_class
    Rack::Request
  end

  def default_url_options
    {}
  end
  def resources_path_names 
    { :new=>'new', :edit=>'edit' }
  end

  def add_route app, conds, reqs, defs, name, anchor
    pp [conds[:path_info], conds[:request_method], name]
  end
end

gem 'rails', '3.2.13'
require 'rails/all'
require 'journey'
require 'forwardable'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/to_query'
require 'active_support/core_ext/hash/slice'
require 'active_support/core_ext/module/remove_method'
require 'action_controller/metal/exceptions'

routes = RouteSet.new

$mapper = ActionDispatch::Routing::Mapper.new routes

def f &block
  $mapper.instance_exec(&block)
end

f { 
resources :posts  do
   resources :comments ,:shallow=>true, :id=>/A-Z/
end

}

  
