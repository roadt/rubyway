# -*- coding: utf-8 -*-

# 8.1. Types, Classes, and Modules

# The most commonly used reflective methods are those for determining the type of an object—what class it is an instance of and what methods it responds to. We introduced most of these important methods early in this book in Section 3.8.4. To review: 

=begin

o.class 
Returns the class of an object o. 

c.superclass 
Returns the superclass of a class c. 

o.instance_of? c 
Determines whether the object o.class == c. 

o.is_a? c 
Determines whether o is an instance of c, or of any of its subclasses. If c is a module, this method tests whether o.class (or any of its ancestors) includes the module. 

o.kind_of? c 
kind_of? is a synonym for is_a?. 

c === o 
For any class or module c, determines if o.is_a?(c). 

o.respond_to? name 
Determines whether the object o has a public or protected method with the specified name. Passes true as the second argument to check private methods as well. 

=end




# 8.1.1. Ancestry and Modules

# In addition to these methods that you've already seen, there are a few related reflective methods for determining the ancestors of a class or module and for determining which modules are included by a class or module. These methods are easy to understand when demonstrated: 

#Code View:
module A; end             # emtpy moudel
module B; include A; end;   #module B includes A

class C; include B; end;   # Class C includes module B

C < B                 # => true: C includes module B
B < A                 # => rue: B includes A
C < A                 # => true

Fixnum < Integer         # => true: all fixnums are integers
Integer<Comparable   # => rue; integers are comparable
Integer <Fixnum        # => false: not all integers are fixnum
String < Numeric       #=> nil: strings are not numbers

A.ancestors            # => [A]
B.ancestors            # => [B,A]
C.ancestors           # => [C, B, A, Object, Kernel]
String.ancestors    # => [String, Enumerable, Comparable, Object, Kernel]
                    # Note: in Ruby 1.9 String is no longer Enumerable

C.include?(B)   # => true
C.include?(A)  #=>true
B.include?(A)  #=>True
A.include?(A) #=>false
A.include?(B) #=>false

A.included_modules #=>[]
B.included_modules #=>[A]
C.included_modules #=>[B,A,Kernel]



# This code demonstrates include?, which is a public instance method defined by the Module class. But it also features two invocations of the include method (without the question mark), which is a private instance method of Module. As a private method, it can only be invoked implicitly on self, which restricts its usage to the body of a class or module definition. This use of the method include as if it were a keyword is a metaprogramming example in Ruby's core syntax. 


# A method related to the private include method is the public Object.extend. This method extends an object by making the instance methods of each of the specified modules into singleton methods of the object: 

module Greeter; def hi; "hello"; end; end  # A silly module 
s = "string object"
s.extend(Greeter)   # Add hi as singleton method to s
s.hi            #=> "hello"
String.extend(Greeter) # Add hi as a class method of String
String.hi  #=> "hello"

# The class method Module.nesting is not related to module inclusion or ancestry; instead, it returns an array that specifies the nesting of modules at the current location. Module.nesting[0] is the current class or module, Module.nesting[1] is the containing class or module, and so on: 

module M
class C
 Module.nesting # => [M::C, M]
end
end


# 8.1.2. Defining Classes and Modules

# Classes and modules are instances of the Class and Module classes. As such, you can create them dynamically: 

M1 = Module.new  # define a new module M
C1 = Class.new       # define a new class C
D = Class.new(C) {   # define a subclass of C
  include M                # that includes module M
}
puts D.to_s

# One nice feature of Ruby is that when a dynamically created anonymous module or class is assigned to a constant, the name of that constant is used as the name of the module or class (and is returned by its name and to_s methods). 
