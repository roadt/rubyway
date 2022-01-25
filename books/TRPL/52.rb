


# 5.2.3 - the for/in loop
array = [1,2,3,4,5]
for element in array
  puts element
end

hash  = { :a=>1, :b=>2, :c=>3 }
for key, value in hash
  puts "#{key} => #{value}"
end



hash  = { :a=>1, :b=>2, :c=>3 }
hash.each do |key, value|
  puts "#{key} => #{value}"
end
