

gem 'activesupport', '3.2.13'
require 'active_support/configurable'
require 'awesome_print'

# u.config
class User
  include ActiveSupport::Configurable
end
u = User.new
u.config.message = 'hello'
u.config.level = 1
u.config.message
u.config.level


# config_accessor
class User
  include ActiveSupport::Configurable
  config_accessor :allowed_access
end

u = User.new
u.allowed_access = true
u.allowed_access
u.config
u.config.allowed_access = false
u.allowed_access
u.config
