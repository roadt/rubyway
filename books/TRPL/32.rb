

puts 'This is a simple Ruby string literal'
puts 'Won\'t you read O\'Reilly\'s book?'
puts

puts 'This string literal ends with a single backslash: \\'
puts 'This is a backslash-quote: \\\''
puts 'Two backslashes: \\\\'

puts ('a\b' == 'a\\b')

puts 'This is a long string literal \
that includes a backslash and a newline'


# 3.2.1.4. Arbitrary delimiters for string literals
  
puts greeintg = <<HERE + <<THERE + "World"
Hello
HERE
There
THERE
