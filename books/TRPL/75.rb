# -*- coding: utf-8 -*-


#7.5 Modules

# Like a class, a module is a named group of methods, constants, and class variables. Modules are defined much like classes are, but the module keyword is used in place of the class keyword. Unlike a class, however, a module cannot be instantiated, and it cannot be subclassed. Modules stand alone; there is no "module hierarchy" of inheritance. 

# Modules are used as namespaces and as mixins. The subsections that follow explain these two uses. 


# Just as a class object is an instance of the Class class, a module object is an instance of the Module class. Class is a subclass of Module. This means that all classes are modules, but not all modules are classes. Classes can be used as namespaces, just as modules can. Classes cannot, however, be used as mixins. 

# 7.5.1. Modules as Namespaces

# Modules are a good way to group related methods when object-oriented programming is not necessary. Suppose, for example, you were writing methods to encode and decode binary data to and from text using the Base64 encoding. There is no need for special encoder and decoder objects, so there is no reason to define a class here. All we need are two methods: one to encode and one to decode. We could define just two global methods: 

def base64_encode
end
def base64_decode
end

# To prevent namespace collisions with other encoding and decoding methods, we've given our method names the base64 prefix. This solution works, but most programmers prefer to avoid adding methods to the global namespace when possible. A better solution, therefore, is to define the two methods within a Base64 module: 

module Base64
  def self.encode data
  end
  def self.decode text
  end
end

# Note that we define our methods with a self. prefix, which makes them "class methods" of the module. We could also explicitly reuse the module name and define the methods like this: 

module Base64
  def Base64.encode data
  end
  def Base64.decode text
  end
end

# Defining the methods this way is more repetitive, but it more closely mirrors the invocation syntax of these methods: 

# This is how we invoke the methods of the Base64 module
text = Base64.encode('some-data')
data = Base64.decode(text)


# Note that module names must begin with a capital letter, just as class names do. Defining a module creates a constant with the same name as the module. The value of this constant is the Module object that represents the module. 

# Modules may also contain constants. Our Base64 implementation would likely use a constant to hold a string of the 64 characters used as digits in Base64: 

module Base64
  DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' \
           'abcdefghijklmnopqrstuvwxyz' \
           '0123456789+/'
end

# Outside the Base64 module, this constant can be referred to as Base64::DIGITS. Inside the module, our encode and decode methods can refer to it by its simple name DIGITS. If the two methods had some need to share nonconstant data, they could use a class variable (with a @@ prefix), just as they could if they were defined in a class. 

module Base64
  def self.encode data
    @@data = data
  end

  def self.decode text
    @@data
  end
end


# 7.5.1.1. Nested namespaces

# Modules, including classes, may be nested. This creates nested namespaces but has no other effect: a class or module nested within another has no special access to the class or module it is nested within. To continue with our Base64 example, let's suppose that we wanted to define special classes for encoding and decoding. Because the Encoder and Decoder classes are still related to each other, we'll nest them within a module: 

module Base64B
  DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  class Encoder
    def encode data
    end
  end
  class Decoder
    def decode text
    end
  end
  # A utility function for use by both classes
  def Base64.helper
  end
end

puts text = Base64B::Encoder.new.encode('some-data')
puts data = Base64B::Decoder.new.decode(text)

# By structuring our code this way, we've defined two new classes, Base64::Encoder and Base64::Decoder. Inside the Base64 module, the two classes can refer to each other by their unqualified names, without the Base64 prefix. And each of the classes can use the DIGITS constant without a prefix. 

# On the other hand, consider the Base64.helper utility function. The nested Encoder and Decoder classes have no special access to the methods of the containing module, and they must refer to this helper method by its fully qualified name: Base64.helper. 

# Because classes are modules, they too can be nested. Nesting one class within another only affects the namespace of the inner class; it does not give that class any special access to the methods or variables of the outer class. If your implementation of a class requires a helper class, a proxy class, or some other class that is not part of a public API, you may want to consider nesting that internal class within the class that uses it. This keeps the namespace tidy but does not actually make the nested class private in any way.

# See Section 7.9 for an explanation of how constant names are resolved when modules are nested. 


# 7.5.2. Modules As Mixins

# The second use of modules is more powerful than the first. If a module defines instance methods instead of the class methods, those instance methods can be mixed in to other classes. Enumerable and Comparable are well-known examples of mixin modules. Enumerable defines useful iterators that are implemented in terms of an each iterator. Enumerable doesn't define the each method itself, but any class that defines it can mix in the Enumerable module to instantly add many useful iterators. Comparable is similar; it defines comparison operators in terms of the general-purpose comparator <=>. If your class defines <=>, you can mix in Comparable to get <, <=, == >, >=, and between? for free. 


# To mix a module into a class, use include. include is usually used as if it were a language keyword: 

class Point 
  include Comparable
  
end

# In fact, it is a private instance method of Module, implicitly invoked on self—the class into which the module is being included. In method form, this code would be: 

class Point
  include(Comparable)
end

# Because include is a private method, it must be invoked as a function, and we cannot write self.include(Comparable). The include method accepts any number of Module objects to mix in, so a class that defines each and <=> might include the line: 


class Point
  include Comparable, Enumerable
end

# The inclusion of a module affects the type-checking method is_a? and the switch-equality operator ===. For example, String mixes in the Comparable module and, in Ruby 1.8, also mixes in the Enumerable module: 

puts "text".is_a? Comparable  # => true
puts Enumerable === "text"  # => true in Ruby 1.8, false in 1.9

# Note that instanceof? only checks the class of its receiver, not superclasses or modules, so the following is false.

puts "text".instance_of? Comparable # => false

# Although every class is a module, the include method does not allow a class to be included within another class. The arguments to include must be modules declared with module, not classes. 

# It is legal, however, to include one module into another. Doing this simply makes the instance methods of the included modules into instance methods of the including module. As an example, consider this code from Chapter 5: 

module Iterable                        # Classes that define next can include this module
  include Enumerable                 # Define iterators on top of each
  def each                                  # And define each on top of next
    loop { yield self.next } 
  end
end


# The normal way to mix in a module is with the Module.include method. Another way is with Object.extend. This method makes the instance methods of the specified module or modules into singleton methods of the receiver object. (And if the receiver object is a Class instance, then the methods of the receiver become class methods of that class.) Here is an example: 

countdown = Object.new       # A plain old object
def countdown.each           # The each iterator as a singleton method
  yield 3
  yield 2
  yield 1
end
countdown.extend(Enumerable) # Now the object has all Enumerable methods  
print countdown.sort         # Prints "[1, 2, 3]"
puts



# 7.5.3. Includable Namespace Modules

# It is possible to define modules that define a namespace but still allow their methods to be mixed in. The Math module works like this: 

print Math.sin(0)    # => 0.0: Math is a namespace 
print include (Math) # The Math namespace can be included
print sin(0)         # => 0.0: Now we have easy access to the functions
puts 

=begin

The Kernel module also works like this: we can invoke its methods through the Kernel namespace, or as private methods of Object, into which it is included. 

If you want to create a module like Math or Kernel, define your methods as instance methods of the module. Then use module_function to convert those methods to "module functions." module_function is a private instance method of Module, much like the public, protected, and private methods. It accepts any number of method names (as symbols or strings) as arguments. The primary effect of calling module_function is that it makes class method copies of the specified methods. A secondary effect is that it makes the instance methods private (we'll have more to say about this shortly). 

Like the public, protected, and private methods, the module_function method can also be invoked with no arguments. When invoked in this way, any instance methods subsequently defined in the module will be module functions: they will become public class methods and private instance methods. Once you have invoked module_function with no arguments, it remains in effect for the rest of the module definition—so if you want to define methods that are not module functions, define those first. 

It may seem surprising at first that module_function makes the instance methods of a module private. The reason to do this is not really for access control, as obviously the methods are also available publicly through the module's namespace. Instead, the methods are made private to restrict them to function-style invocation without an explicit receiver. (The reason that these are called module functions instead of module methods is that they must be invoked in functional style.) Forcing included module functions to be invoked without a receiver makes it less likely that they'll be mistaken for true instance methods. Suppose we're defining a class whose methods perform a lot of trigonometry. For our own convenience, we include the Math module. Then we can invoke the sin method as a function instead of calling Math.sin. The sin method is implicitly invoked on self, but we don't actually expect it to do anything to self. 


When defining a module function, you should avoid using self, because the value of self will depend on how it is invoked. It is certainly possible to define a module function that behaves differently depending on how it is invoked. But if you are going to do that, then it makes more sense to simply define one class method and one instance method. 


=end

module A
  def self.f1
    puts "f1"
  end
end

A.f1

module B
  def f1
    puts "B.f1"
  end

  def f2
    puts "B.f2"
  end

  module_function   :f1,:f2
end

B.f1;B.f2
include(B)
f1;f2

