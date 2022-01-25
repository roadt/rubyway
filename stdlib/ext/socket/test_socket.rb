
require 'awesome_print'

ap Socket.constants
ap Socket::Constants.constants

s = Socket.new Socket::AF_INET, Socket::SOCK_STREAM
s.connect Socket.pack_sockaddr_in(80, '163.com')
s.write("GET / \r\n")
s.read
s.close
