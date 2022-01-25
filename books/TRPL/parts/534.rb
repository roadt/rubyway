

s = "hello"
print s.enum_for(:each_char).map {|c| c.succ}
print s.chars.map {|c| c.succ}

enumerator = 3.times
enumerator.each {|x| print x}

# downto returns an enumerator with a select method
print 10.downto(1).select {|x| x%2 == 0}

# each_byte iterator returns an enumerator with a to_a method
print "hello".each_byte.to_a



# use to_enum for itself.
def twice
  if block_given?
    yield
    yield
  else
    self.to_enum(:twice)
  end
end

twice .tap {|x| print x.inspect}

for line,number in s.each_char.with_index
  puts "#{number+1}: #{line}"
end

