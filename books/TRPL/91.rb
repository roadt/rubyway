
#  concatentation(+),  append (<<), repetation (*) , indexing ([]).

puts s = "hello"
puts s.concat(" world")  # synomym for <<. Mutating append to s. return new s
puts s.insert(5, " there")  # same as s[5] = "there". Alters s. return new s
puts s.slice(0,5)               # same as s[0,5]. returns a substring
puts s.slice(5,6)               # deletioin. same as s[5,6] = "". returns deleted substring
puts s.eql?("hello world")  # True. same as ==.

#  length of a string
puts s.length   # => 5: counts chars in 1.9, bytes in 1.8
puts s.size        # => 5: size is asynonym
puts s.bytesize # => 5: length in bytes; Ruby 1.9 only
puts s.empty?  # => false
puts "".empty? # => true

s = "hello"
# finding the position of a substirng or pattern match
s.index("l")  # => 2: index of first l in string




# Packing/Unpacking Binary Strings

print a = [1,2,3,4,5,6,7,8,9,10]  # An array of 10 integers
print b = a.pack('i10')                 # Pack 10 4-bytes integers (i) into binary sring b
print c = b.unpack('i*')               # Decode all (*) the 4-byte integers from b
puts c == a                                # => true

m = 'hello world'                 # A message to encode
print data = [m.size, m]           # legnth first, then the bytes
template = 'Sa*'   # Unsigned short, any number of ASCII chars
print b = data.pack(template)   # => "\v\000hello world"
print b.unpack(template)               # => [11, "hello world"]


# 9.1.3  String and Encoding
# The String methods encoding, encode, encode!, and force_encoding and the Encoding class were described in Section 3.2.6. 
