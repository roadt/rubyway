
require 'drb/drb'

URI = 'druby://localhost:8787'

DRb.start_service

server = DRbObject.new_with_uri URI
puts server.current
