


require 'socket'

TCPServer.open('localhost', 9999) do |serv|
  puts serv
end
