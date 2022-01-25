

require 'thread'

t = Thread.new {  puts 'x' ; puts 'y' }
puts t.status

a = Thread.new { puts 'a'; Thread.stop; puts 'c'}
sleep 0.1 while a.status!='sleep'
puts  "Got here"
a.run
a.join
