
    require 'sinatra/base'
    require 'sinatra/rabbit'

    class MySinatraApp < Sinatra::Base
      include Sinatra::Rabbit

      collection :images do
        description "Images description"

        collection :subcollection do
          description "Images subcollection"

          operation :index do
            description "Hello world"
            control do
              status 200
            end
          end
        end

        operation :index, :if => lambda { 1 == 1} do
          description "Index operation description"
          control do
            status 200
            "Hello from index operation"
          end
        end

        operation :show do
          description "Index operation description"
          param :id,  :string, :required
          param :r1,  :string, :optional, "Optional parameter"
          param :v1,  :string, :optional, [ 'test1', 'test2', 'test3' ], "Optional parameter"
          param :v2,  :string, :optional, "Optional parameter"
          control do
            "Hey #{params}"
          end
        end
      end
    end

    MySinatraApp.run!
