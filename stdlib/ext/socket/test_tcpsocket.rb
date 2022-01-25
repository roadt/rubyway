



s  = TCPSocket.new('163.com', 80)
s.write("GET /\r\n")
s.read()
