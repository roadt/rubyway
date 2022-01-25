

3.times { puts 'thank you!'}
[1,3,4].each {|x| puts x}
[1,2,3].map {|x| x*x}
factorial = 1
2.upto(10) {|x| factorial *= x}
puts factorial

#.tap , yield the caller. i.e. become object to iterator.
chars = "hello,world".tap {|x| puts "original object: #{x.inspect}"}
  .each_char.tap{|x| puts "each_char returns: #{x.inspect}"}
  .map{|c| c.succ} .tap{|x| puts "map returns: #{x.inspect}"}
  .sort.tap {|x| puts "sort returns: #{x.inspect}"}

puts chars 

