

# Modules As Mixins

class Point
  include Comparable
end

class Point2
  include(Comparable)
end

class Point3
  include Enumerable, Comparable
end


# include affect type-checking of is_a? and swtich-equality ====
puts "text".is_a? Comparable
puts Enumerable === "text"

# instaceof? only checks the class of its reciever, not superclass or modules
puts "text".instance_of? Comparable 


module Iterable
  include Enumerable
  def each
    loop { yield self.next }
  end
end



countdown = Object.new
def countdown.each
  yield 3
  yield 2
  yield 1
end
countdown.extend(Enumerable)
print countdown.sort
