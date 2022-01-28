gem 'railties', '3.2.13'
require 'rails/all'
require 'awesome_print'



#===== initializer
class RailtieA < Rails::Railtie
  initializer 'a - init - 1' do 
    ap 'a - init - 1'
  end
end
RailtieA.instance.run_initializers

class RailtieB < Rails::Railtie
  initializer 'b - int - 1' do |app|
    ap ['b - init - 1', app.middlewares, self]
  end
end
RailtieB.instance.run_initializers 1

# use before or after
class RailtieC < Rails::Railtie
  initializer 'c-init -2' , after: 'c - init - 1'do |app|
    ap 'c-init-2'
  end
  initializer 'c - int - 1' do |app|
    ap 'c-init-1'
  end
end
RailtieC.instance.run_initializers


class App < Rails::Railtie
  def initialize
    
  end
end
RailtieC.instance.run_initializers
