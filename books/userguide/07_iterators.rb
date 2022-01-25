#!/usr/bin/ruby

# ver "iterate" - means to do the same thing many times.
# 'iterator" is smoething that does the same thing many times.

# String's useful iterators.

"abc".each_byte{|c| printf "<%c>", c}; print "\n"


s="abc"; i= 0
while i<s.length
  printf "<%c>", s[i]; i+=1
end; print "\n"


"a\nb\nc\n".each_line{|l| print l}

# for statement does iteration by way of an each iterator.
# String's each works the same as each_line. so rewrite:


#for l in "a\nb\nc\n"
#  print l
#end
#error? qr_56610xN.rb:21:in `<main>': undefined method `each' for "a\nb\nc\n":String (NoMethodError)
#why.. 
# because ruby1.9 remvoe String.each method. try String.chars
for c in "a\nb\nc\n".chars
print c
end



# can use control strcutre "retry" in conjunction with n iterated loop. it will retry the loopfrom rbegging.
c=0
for i in 0..4
  print i
  if (i==2 and c==0)
    c = 1
    print "\n"
#    retry
  end
end
print "\n"
#retry is not valid outof rescue statement in ruby1.9.  use it in ruby1.8


# yield can define an iterator.
# yield moves control to the block of code.
def repeat(num)
  while num >0
    yield
    num -= 1
  end
end

repeat(3) { puts "foo" }

# xx
=begin
def WHILE(cond)
  return if not cond
  yield
  retry
end

i=0; WHILE(i<3) { print i; i+=1}
=end

