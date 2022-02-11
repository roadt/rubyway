

# server
  require 'byebug/core'
  Byebug.wait_connection = true
  Byebug.start_server('localhost', 8888)


# byebug -R localhost:8888
# break  module#method
