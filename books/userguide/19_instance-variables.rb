
# begin with @
# scope is confined to whatever object self refers to.

# objects of same class can have different values.
# instance variable can not be altered or observed from out sdie of the object. (never public).
# don't need decare. most appended to object when it is first assigned.

class InstTest
  def set_foo(n)
    @foo = n
  end
  
  def set_bar(n)
    @bar = n
  end
end

i = InstTest.new

puts i.set_foo(2)
puts i.set_bar(4)

puts i
