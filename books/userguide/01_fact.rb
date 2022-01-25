
def fact(n)
  if n == 0
    1
  else
    n * fact(n -1 )
  end
end

puts fact(ARGV[0].to_i)

puts fact(1)
puts fact 5
puts fact 40
puts fact 400




#
puts "hello, world"
puts "good-by world"

