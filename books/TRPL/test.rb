# - encoding : utf-8 - 

# enumerator must .each 
s = 1.upto(6) 
s.each  {|x| puts x}

#


def f
  print self.inspect
end

class A
  print 'a'
  puts  self.inspect
  puts 'b'
end

A.new


# test conflict between class instance variable and instance variable.
# result: no conflicts. instance methdo always access instance variable. class method always access class instance methods.
class A
  @a = 1
  @b = 2
  def a=(v)
    @a = v
    @b = v
  end
  def a
    [@a,@b]
  end

  def self.p
    [@a,@b]
  end
  class << self
  attr_accessor :a, :b
    end
end
print [a = A.new, A.p,a.a, a.a=3,A.p,a.a, A.a, A.b],"\n"



# test the object 's private method from source code reading.

class B 
  def self.singleton_method_added(*rest)
    print ["singleton_method_added", *rest], "\n"
  end

  def self.singleton_method_removed(*rest)
    print ['singleton_method_removed', *rest], "\n"
  end
  
  def singleton_method_undefined(*rest)
    print ['singleton_method_undefined', *rest], "\n"
  end

  def self.method_added *rest
    print ['method_added', *rest], "\n"
  end
  
  def self.method_removed *reset
    print ['method_removed', *rest], "\n"
  end

  def self.method_undefined *rest
    print ['method_undefined', *rest], "\n"
  end

  def singleton_method_added *rest
    print ['instance-singleton_method_aded', *rest], "\n"
  end

  def g *rest
    print *rest, "\n"
  end
end

def B.f
  puts "B.f"
end

b = B.new

def b.if
  puts 'b.if'
end



# encoding
3.times do puts 'オッパ江南スタイル' end 


# test included methdo.

module M
  def self.included *rest
    print ['included', *rest]
    mod = rest[0]
    def mod.ff
      puts 'class.f'
    end
    raise Exception.new 'ex in c.inclued'
  end

  def ff 
    puts 'instance.f'
  end
end

class D
  def self.included *rest
    print ['D.included', *rest]
  end
  
  begin 
    include M
  rescue Exception =>ex
    puts ex
  end

  ff

end
D.new.ff


# test inhertied  method.

class A
  def self.inherited *rest
    print ['A.inhertied', *rest], "\n"
  end
end

class E < A
end



# test class constant
class E
  x = 1
  y = 2

  BIND = binding
end
print  E::BIND


#  String..

class String
  alias each each_char
  include Enumerable
end

for i in "xxxx" do puts  i  end


# Module.instance_methods
print BasicObject.instance_methods, BasicObject.public_instance_methods, BasicObject.private_instance_methods, BasicObject.protected_instance_methods, "\n"



# C.new block


C = Class.new do 
  public
  def f
    puts 'f'
  end

end
C.new.f

C.new do 
  print self
end

gem 'actionpack'







