require 'active_support/core_ext/module/delegation'
require 'pp'

###  delegate
class A
  def f
    'A.f'
  end

  def g
    'A.g'
  end
end

class B
  attr_accessor :a
  def initialize
    self.a = A.new
  end
  delegate :f, :g, :to =>  :a
end

b = B.new
puts b.f
puts b.g


# prefix delegate

class C
  attr_accessor :a
  def initialize
    self.a = A.new
  end

  delegate :f, :g, :to => :a, :prefix=>true

  delegate :f, :g, :to => :a, :prefix=>:aa
end

c= C.new
puts c.a_f
puts c.a_g
puts c.aa_f
puts c.aa_g


# allow-nil
class D
  attr_accessor :a
  
  delegate :f, :to=>:a, :allow_nil => true   # return nil when a is nil
  delegate :g, :to=>:a    # raise Error
end

d = D.new
pp d.f
pp d.g
