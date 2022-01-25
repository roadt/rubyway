#!/usr/bin/ruby

class Fruit
  def set_kind(k)
    @kind = k
  end
  def get_kind
    @kind
  end
end

puts f1 = Fruit.new
puts f1.set_kind("peach")
puts f1.get_kind
puts f1


# property support
class Fruit2
  def kind=(k)
    @kind=k
  end
  def kind
    @kind
  end
end



#inspect method
class Fruit3
  def kind=(k)
    @kind=k
  end
  def kind
    @kind
  end
  def inspect
    "a fruit of the #{@kind} variety"
  end
end


puts f3 =Fruit3.new
puts f3.kind = "banana"
puts f3.kind
puts f3


=begin
Making accessors the easy way

Since many instance variables need accessor methods, Ruby provides convenient shortcuts for the standard forms.

Shortcut	 Effect
attr_reader :v	 def v; @v; end
attr_writer :v	 def v= (value); @v= value; end
attr_accessor :v	 attr_reader :v; attr_writer :v
attr_accessor :v, :w	 attr_accessor :v; attr_accessor :w

=end

class Fruit4
  attr_accessor :condition , :kind
  def inspect
    "(inspect) a #{@condition} #{@kind}"
  end
  def to_s
        "(to_s) a #{@condition} #{@kind}"
  end
end

puts f4 = Fruit4.new
puts f4.condition = "rpie"
puts f4.kind = "kind"
puts f4



