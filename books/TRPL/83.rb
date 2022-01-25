# -*- coding: utf-8 -*-

# 8.3. Variables and Constants

# Kernel, Object, and Module define reflective methods for listing the names (as strings) of all defined global variables, currently defined local variables, all instance variables of a boejct, all class variables of a class or module, and all constants of a class or module:

print global_variables, "\n"       # => ["$DEBUG", "$SAFE", ..]
x = 1  # define a local var
print local_variables, "\n"

# define a simple class
class Point
def initialize(x,y); @x,@y= x,y;end #define instance variables
@@classvar = 1   #define class var
ORIGIN = Point.new(0,0)   #define constant
end

print Point::ORIGIN.instance_variables     #=>["@y", "@x"]
print Point.class_variables                        #=>["@@classvar"]
print Point.constants                               #=>["ORIGIN"]



# The global_variables, instance_variables, class_variables, and constants methods return arrays of strings in Ruby 1.8 and arrays of symbols in Ruby 1.9. The local_variables method returns an array of strings in both versions of the language. 


# In addition to listing defined variables and constants, Ruby Object and Module also define reflective methods for querying, setting, and removing instance variables, class variables, and constants. There are no special purpose methods for querying or setting local variables or global variables, but you can use the eval method for this purpose: 

puts x = 1
puts varname = 'x'
puts eval(varname)  # => 1
puts eval("varname = '$g'") # set varname  to "$g"
puts eval("#{varname}= x") # set $g to 1
puts eval(varname) # => 1

# Note that eval evaluates its code in a temporary scope. eval can alter the value of instance variables that already exist. But any new instance variables it defines are local to the invocation of eval and cease to exist when it returns. (It is as if the evaluated code is run in the body of a block—variables local to a block do not exist outside the block.) 



# You can query, set, and test the existence of instance variables on any object and of class variables and constants on any class or module: 

puts o = Object.new
puts o.instance_variable_set(:@x, 0) # Note required @prefix
puts o.instance_variable_get(:@x)  #=> 0
puts o.instance_variable_defined?(:@x)  #=>true

puts Object.class_variable_set(:@@x, 1)  #private in ruby 1.8
puts Object.class_variable_get(:@@x)  # private in ruby 1.8
puts Object.class_variable_defined?(:@@x) # => true, Ruby1.9 and later

puts Math.const_set(:EPI, Math::E*Math::PI)
puts Math.const_get(:EPI)   # => 8.53973422267357
puts Math.const_defined? :EPI #=> true

# In Ruby 1.9, you can pass false as the second argument to const_get and const_defined? to specify that these methods should only look at the current class or module and should not consider inherited constants. 

module M1 
A = 1
end

module M2 
include M1
B = 2
end

print [M2.const_defined?(:B), M2.const_defined?(:A), M2.const_defined?(:A,false)]

class C1
@@a = 1
end

class C2
@@b = 2
end

print [C2.class_variable_defined?(:@@b), C2.class_variable_defined?(:@@a), C1.class_variable_defined?(:@@a)]
puts

# The methods for querying and setting class variables are private in Ruby 1.8. In that version, you can invoke them with class_eval: 

puts String.class_eval { class_variable_set(:@@x, 1) }  # Set @@x in String
puts String.class_eval { class_variable_get(:@@x) }     # => 1

# Object and Module define private methods for undefining instance variables, class variables, and constants. They all return the value of the removed variable or constant. Because these methods are private, you can't invoke them directly on an object, class, or module, and you must use an eval method or the send method (described later in this chapter): 

puts o.instance_eval { remove_instance_variable :@x }
#puts String.class_eval { remove_class_variable(:@@x) }
puts Math.send :remove_const, :EPI  # Use send to invoke private method

# The const_missing method of a module is invoked, if there is one, when a reference is made to an undefined constant. You can define this method to return the value of the named constant. (This feature can be used, for example, to implement an autoload facility in which classes or modules are loaded on demand.) Here is a simpler example: 

def Symbol.const_missing(name)
name # return the constant name as a symbol
end

print Symbol::Test # => :Test   
                      # undefined constant evluates to a Symbol

