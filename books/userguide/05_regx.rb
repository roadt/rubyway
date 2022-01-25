#!/usr/bin/ruby
# require an ANSI termianl

st = "\033[7m"
en = "\033[m"

puts "Enter an empty string at any time to exit."

while true
print "str> "; STDOUT.flush; str = STDIN.gets.chop
break if str.empty?
print "pat> "; STDOUT.flush; pat = STDIN.gets.chop
break if pat.empty?
re = Regexp.new(pat)
puts str.gsub(re, "#{st}\\&#{en}");
end


