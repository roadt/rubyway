

[1,2,3].each {|x| print x}
(1..3).each {|x| print x}


File.open('/home/roadt/1.c') do |f|
  f.each{|line| print line}
end

File.open('/home/roadt/1.c') do |f|
  f.each_with_index do |line,number|
    print "#{number}: #{line}"
  end
end


squares = [1,2,3].collect {|x| x*x}
puts squares

evens = (1..10).select {|x| x%2==0}
puts evens

odds = (1..10).reject {|x| x%2 == 0}
puts odds

data = [2,5,3,4]
sum = data.inject{|sum,x| sum + x}
floatprod = data.inject(1.0){|p,x| p*x}
max = data.inject {|m,x| m>x ? m : x}
puts data, sum, floatprod, max
