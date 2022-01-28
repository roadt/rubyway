

gem 'railties'
require 'rails/paths'

include Rails::Paths
root = Root.new '/rails'
root.add 'app/controllers', eager_load: true

path = root['app/controllers']
path.eager_load?  # => true
path.is_a?(Rails::Paths::Path)

# The +Path+ object is simply an enumerable and allows you to easily add extra paths:
path.is_a?(Enumerable)
path.to_ary.inspect
path << "lib/controllers"
path.to_ary.inspect

root["app/controllers"].expanded # => ["/rails/app/controllers"]
root["app/controllers"].existent # => ["/rails/app/controllers"]

# paths, filtered version
root.all_paths
root.autoload_once 
root.eager_load
root.autoload_paths
root.load_paths

#
root.add 'config/routes'
root['config/routes'].inspect

root.add 'config/routes', with:'config/routes.rb'
root['config/routes']
