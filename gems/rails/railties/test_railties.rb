


gem 'railties', '3.2.13'
require 'rails/all'

require 'awesome_print'

Rails::Info

puts Rails::Railtie.subclasses
puts Rails::Engine.subclasses
puts Rails::Engine::Railties.railties
puts Rails::Engine::Railties.engines


