
puts "abc"
puts 'abc'

puts "a\nb\nc";
puts 'a\nb\nc';
puts "\n"
puts '\n'
puts "\001"
puts '\001'
puts "abcd #{5*3} efg"

var = " abc  "
puts "1234#{var}5678"

puts "foo" + "bar"
puts "foo" * 2


# concatentation
puts word = "fo" + "o"

#repetition
puts word = word * 2

#char extraction
puts word[0]
puts word[-1]

#substr extration
herb="pareley"
puts herb[0,1]
puts herb[-2,2]
puts herb[0..3]
puts herb[-5..-2]

# test for equality
puts "foo" == "foo"
puts "foo" == "bar"
