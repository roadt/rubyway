
require 'socket'


UNIXSocket.pair {|s1, s2|
  s1.puts "Hello, world"
  p s2.recv(4)
  p s2.recv(4, Socket::MSG_PEEK)
  p s2.recv(4)
  p s2.recv(10)
}

def safe_eval2(str,i=4)
  Thread.start {            # Start sandbox thread
    $SAFE = i               # Upgrade safe level
    eval(str)               # Eval in the sandbox
  }.value                   # Retrieve result
end
