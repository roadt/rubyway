
# External iterators

iter = 9.downto(1)
begin
print iter.next while true
rescue StopIteration
  puts "...blashtoff!"
end


#Kernel.loop implements implicit
iter = 9.downto(1)
loop do 
  print iter.next
end
puts '...blashtoff!'
