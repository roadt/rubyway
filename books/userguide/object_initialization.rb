


# initialize method
class Fruit
  def initialize
    @kind = "apple"
    @condition = "ripe"
  end

  def to_s
    "#{@kind} #{@condition}"
  end
end

puts f1 = Fruit.new


# changing assumption to requirements

class Fruit2
  def initialize(k)
    @kind =  k
    @condition = "ripe"
  end
  def to_s
    "#{@kind} #{@condition}"
  end
end

f5 = Fruit2.new "mango"
puts f5
#puts f6 = Fruit2.new  # :in `initialize': wrong number of arguments (0 for 1) (ArgumentError)


# flexible initialization
# default argument

class Fruit3
  def initialize (k="apple")
    @kind = k
    @condition = "ripe"
  end
  def to_s
    "#{@kind} #{@condition}"
  end
end

f5 = Fruit3.new "mango"
f6 = Fruit3.new
puts f5,f6
