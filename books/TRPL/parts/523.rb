

# The for/in Loop

=begin

for var in collection do
  body
end

collection - any object has a each iterator method
=end

#print array
array = [1,2,3,4,5]
for e in array
  puts e
end

# print keys and values in a hash
hash = {:a=>1, :b=>2, :c=>3}
for k,v in hash
  puts "#{k} => #{v}"
end
print k,v,"\n"

hash.each do |k,v|
  puts "#{k} => #{v}"
end
print k,v,"\n"
