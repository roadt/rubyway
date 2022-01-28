

require 'journey'

class App
  def self.call(env)
    puts env
  end
end

routes = Journey::Routes.new
routes.add_route  App, '/', {}, {}

router = Journey::Router.new routes, {}
router.call({'PATH_INFO'=> '/'})
