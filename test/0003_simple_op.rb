
puts "abc"
puts 'abc'
puts "a\nb\nc"
puts 'a\nb\n'
puts "\n"
puts '\n'
puts "\001"
puts '\001'
puts "abcd #{5*3} efg"
var = " abc "
puts "1234#{var}5678"

puts "foo" + "bar"
puts "foo" * 2


#concatenation
word = "fo" + "o"
puts word
# repetition
word = word * 2
puts word
# extracting character (note character are integers in ruby)
puts word[0]  #102 is ASCII code of `f'
puts word[-1] #111 is ASCII code of `o'

#extract substring
herb = "parsley"
puts herb[0,1]
puts herb[-2,2]
puts herb[0..3]
puts herb[-5..-2]

#test for quality
puts "foo" == "foo"
puts "foo" == "bar"
