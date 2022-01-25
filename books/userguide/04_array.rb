

#private helper function
def puta(arr)
puts '[' + arr.join(',') + ']'
end


puts '-------- array --------'
#create array with  brackets ([]) and separating them with commas.
#can accomodate diverse object types.
ary = [1,2,"3"]

# concatenation and repeatation (just like string)
puta ary + ["foo", "bar"]
puta ary * 2

# extraction
puts ary[0]
puta ary[0,2]
puta ary[0..1]
puts ary[-2]
puta ary[-2,2]
puta ary[-2..-1]


# arr to string, or back.

puts str = ary.join(':')
puta str.split(':')

#Hashes

=begin
An associative array has elements that are accessed not by sequential index numbers, but by keys which can have any sort of value. Such an array is sometimes called a hash or dictionary; in the ruby world, we prefer the term hash. A hash can be constructed by quoting pairs of items within curly braces ({}). You use a key to find something in a hash, much as you use an index to find something in an array.
=end

puts '--------- hash --------'
h = { 1=>2, "2"=>"4"}
puts h[1]
puts h["2"]
puts h[5]

h[5] = 10
puts h
h.delete 1
puts h[1]
puts h

