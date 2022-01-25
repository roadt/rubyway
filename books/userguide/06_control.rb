
# -------- case ----------
# similar and mor powerful C-swtich.

i = 8
case i
when 1, 2..5
  puts "1..5"
when 6..10
  puts "6..10"
end

# 2..5 is expression which means the range between 2 and 5. inclusive
# test using this:
puts (2..5) === i

#case intenally uses the relationship operator === to check condition once a time.

case 'abcdef'
  when 'aaa', 'bbb'
  puts 'aaa or bbb'
when /def/
  puts 'includes /def/'
end



# ----- while -----------

# a repated if
# took form  "while condition ... end"
# also can easy be applied to individual statements.

puts '-- while 1 -- '
i = 0
puts "It's zero." if i  == 0
puts "It's negative." if i<0

puts i+=1 while i<3

# use "unless" to negate test condition.  an "unless" is a negated if.


# interrupt the progress of a loop. 
# 1, break - eascap efor the loop entirely.
# 2, next - skip to the next iteration
# 3, redo - restart current iteration
# maybe 4? return.   return value is nill without explicit specified.

puts '--- while 2 ---'
i = 0
while true
  i = i+1
  if i == 5
    next
  end
  if i == 6
    redo
  end

  if i == 10
      break;
  end
  puts i
end





# --------- for -----------
# run each element in a collection (array, hash, numeric sequence, etc)

#for elt in collection
# #... here, elt refers to an elemtn of the collection
#end

puts '-- for --'
for num in (4..6)
  puts num
end

puts '-- for 2 --'
for elt in [100, -9.6, "pickle"]
  puts "#{elt}\t(#{elt.class})"
end

# for is actually naother way of wrign echo.
(4..6).each { |c| puts c}
