

# Rspec implementa recusively describe mechanism 
# to define a hierachy of chidlen of children  ... of root class.

# here try to impl sipmle one.  root class C.

# use describe '' you can get

#  C.children
#       c1.children
#           ....
#       c2.children
#          c21...

# every C has it 'its'. puts  C.its.  which is a array of strings.


class C
  
  def self.describe(*args, &block)
    child = subclass(self, &block)
    children <<      child
    child
  end

  def self.subclass(parent, &block)
    c =  Class.new(parent) 
    c.module_eval(&block) if block
    c
  end

  def self.children
    @children ||= []
  end

  def self.it n
    @its ||= []
    @its << n
  end

  def self.its
    @its
  end

end

# ----------------- inject to man module --------------
module  M
  def describe(*args, &block)
    C.describe(*args, &block)
  end
end
extend M

#-----------------------  use --------------------------
describe "aa" do
  it "a1"
  it "a2"
  describe "bb" do
    it "b1"

    it "b2"
  end
end


### -------- test -----------
require 'pp'
alias :old_puts :puts
alias :puts :pp

puts C.children
c = C.children[0]
puts c
puts c.its

puts c.children
c2 = c.children[0]
puts c2
puts c2.its
