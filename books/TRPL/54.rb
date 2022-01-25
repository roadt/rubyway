
1.upto(10) {|x| puts x}
1.upto(10) do |x|
  puts x
end
1.upto(10)      # No block specified
#{|x| puts x}    # Syntax error: block not after an invocation
1.upto(3) {|x| puts x}
1.upto 3 do |x| puts x end
#1.upto 3 {|x| puts x}

hash = { :girl=>3, :body=>'hello'}
hash.each do |key, value|   # For each (key,value) pair in the hash
  puts "#{key}: #{value}"   # Print the key and the value
end           


#5.4.2 Teh value of a block

words = ['hello', 'world', 'girl', 'boy']
print words.sort! {|x,y| x<=>y}

  [1,2,3].collect do |x|
  next 0 if x == nil
  next x, x*x
end

[1,2,3].collect do |x|
  if x == nil
    0
  else
    [x, x*x]
  end
end


# 5.4.3. Blocks and Variable Scope

# 
total = 0   
[1,2,3,4,5].each {|x| total += x }  # Sum the elements of the data array
puts total                   # Print out that sum



1.upto(10) do |i|         # 10 rows
  1.upto(10) do |i|       # Each has 10 columns
    print "#{i} "         # Print column number
  end
  print " ==> Row #{i}\n" # Try to print row number, but get column number
end



x = y =z = 0            # local variables
1.upto(4) do |x;y,z|   # x and y are local to block
                     # x and y "shadow" the outer variables
  y = x + 1          # Use y as a scratch variable
  z = y + 1
  puts y*y           # Prints 4, 9, 16, 25
end
print [x,y,z]                # => [0,0]: block does not alter these


# hash.each {|key,value; i,j,k| ... }


#5.4.4 Passing Arugments to a block

