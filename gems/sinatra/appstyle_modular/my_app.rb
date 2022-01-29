
require 'sinatra/base'

class  MyApp < Sinatra::Base
  ## app code ..ehre

  get '/' do 
    'Hello World'
  end

  run! if app_file == $0
end

