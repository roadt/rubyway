
# 8.4. Methods

def puts *rest
   print(*rest, "\n")
end

# The Object and Module classes define a number of methods for listing, querying, invoking, and defining methods. We'll consider each category in turn. 

# 8.4.1. Listing and Testing For Methods

# Object defines methods for listing the names of methods defined on the object. These methods return arrays of methods names. Those name are strings in Ruby 1.8 and symbols in Ruby 1.9: 

puts o = "a string"
puts o.methods     # => names of all public methods 
puts o.public_methods # => the same thing
puts o.public_methods(false)  # exclude inherted methods
puts o.protected_methods  # => []: there aren't any
puts o.private_methods  # => array of all private methods
puts o.private_methods(false)  # exclude inehrited private method
def o.single; 1; end  # define a singleton methods
puts o.singleton_methods  # => ["single"] (or [:single] in 1.9)

# It is also possible to query a class for the methods it defines rather than querying an instance of the class. The following methods are defined by Module. Like the Object methods, they return arrays of strings in Ruby 1.8 and arrays of symbols in 1.9: 

puts String.instance_methods == "s".public_methods  # => true
puts String.instance_methods(false) == "s".public_methods(false)  #=> true
puts String.public_instance_methods == String.instance_methods # => true
puts String.protected_instance_methods  #=> []
puts String.private_instance_methods(false)  #=> ["initialize_copy",   "initialize"]

# Recall that the class methods of a class or module are singleton methods of the Class or Module object. So to list class methods, use Object.singleton_methods: 

puts Math.singleton_methods   # => ["acos", "log10", "atan2", ... ]

# In addition to these listing methods, the Module class defines some predicates for testing whether a specified class or module defines a named instance method: 

puts String.public_method_defined? :reverse #=>true
puts String.protected_method_defined? :reverse #=>false
puts String.private_method_defined? :initialize #=>true
puts String.method_defined? :upcase!  #=> true

# Module.method_defined? checks whether the named method is defined as a public or protected method. It serves essentially the same purpose as Object.respond_to?. In Ruby 1.9, you can pass false as the second argument to specify that inherited methods should not be considered. 

# 8.4.2 Obtaining Method Objects

# To query a specific named method, call method on any object or instance_method on any module. The former returns a callable Method object bound to the receiver, and the latter returns an UnboundMethod. In Ruby 1.9, you can limit your search to public methods by calling public_method and public_instance_method. We covered these methods and the objects they return in Section 6.7: 

puts "s".method(:reverse)  #=>Method object
puts String.instance_method(:reverse) #=>UnboundMethdo object


# 8.4.3. Invoking Methods

# As noted earlier, and in Section 6.7, you can use the method method of any object to obtain a Method object that represents a named method of that object. Method objects have a call method just like Proc objects do; you can use it to invoke the method. 
    
# Usually, it is simpler to invoke a named method of a specified object with send: 

puts "hello.".send :upcase # => "HELLO" : invoke an instance emthod
puts Math.send(:sin, Math::PI/2) #=> 1.0: invoke a class method

# send invokes on its receiver the method named by its first argument, passing any remaining arguments to that method. The name "send" derives from the object-oriented idiom in which invoking a method is called "sending a message" to an object. 

# send can invoke any named method of an object, including private and protected methods. We saw send used earlier to invoke the private method remove_const of a Module object. Because global functions are really private methods of Object, we can use send to invoke these methods on any object (though this is not anything that we'd ever actually want to do): 

"hello".send :puts, "world."

# Ruby 1.9 defines public_send as an alternative to send. This method works like send, but will only invoke public methods, not private or protected methods: 

#"hello".public_send :puts, "world" # raise NoMethodError

# send is a very fundamental method of Object, but it has a common name that might be overridden in subclasses. Therefore, Ruby defines __send__ as a synonym, and issues a warning if you attempt to delete or redefine __send__. 

"hello.".__send__ :puts, "world."

# 8.4.4. Defining, Undefining, and Aliasing Methods

# If you want to define a new instance method of a class or module, use define_method. This instance method of Module takes the name of the new method (as a Symbol) as its first argument. The body of the method is provided either by a Method object passed as the second argument or by a block. It is important to understand that define_method is private. You must be inside the class or module you want to use it on in order to call it: 

# Add an instance methdo named m to class c with body b
def add_method(c,m, &b)
c.class_eval {
define_method(m, &b)
}end

puts add_method(String, :greet) { "Hello," + self }

puts "world".greet # => "Hello, world"

=begin

Defining Attribute Accessor Methods

The attr_reader and attr_accessor methods (see Section 7.1.5) also define new methods for a class. Like define_method, these are private methods of Module and can easily be implemented in terms of define_method. These method-creation methods are an excellent example of how define_method is useful. Notice that because these methods are intended to be used inside a class definition, they are not hampered by the fact that define_method is private. 

=end

# To define a class method (or any singleton method) with define_method, invoke it on the eigenclass: 

def add_class_method(c, m, &b) 
  eigenclass = class << c; self; end
  eigenclass.class_eval {
    define_method(m, &b)
  }
end

def add_class_method2(c, m,&b)
 eigenclass = c.singleton_class
 eigenclass.define_method(m, &b)
end


add_class_method(String, :greet) {|name| "Hello, " + name }
add_class_method(String, :greet2) {|name| "hello, " + name }
puts String.greet("world") #=> "Hello, world"
puts String.greet2("word2")


# In Ruby 1.9, you can more easily use define_singleton_method, which is a method of Object: 

String.define_singleton_method(:greet3) {|name| "hello, " + name }
puts String.greet3("world3")

# One shortcoming of define_method is that it does not allow you to specify a method body that expects a block. If you need to dynamically create a method that accepts a block, you will need to use the def statement with class_eval. And if the method you are creating is sufficiently dynamic, you may not be able to pass a block to class_eval and will instead have to specify the method definition as a string to be evaluated. We'll see examples of this later in the chapter. 

# To create a synonym or an alias for an existing method, you can normally use the alias statement: 

class String
alias plus +   # Make "plus" a symonym for the  + operator
end

# When programming dynamically, however, you sometimes need to use alias_method instead. Like define_method, alias_method is a private method of Module. As a method, it can accept two arbitrary expressions as its arguments, rather than requiring two identifiers to be hardcoded in your source code. (As a method, it also requires a comma between its arguments.) alias_method is often used for alias chaining existing methods. Here is a simple example; we'll see more later in the chapter: 

# Create an alias for the method m in the class (or module) c
def backup(c, m, prefix="o")
n = "#{prefix}_#{m}"  #compute teh alias
c.class_eval {     # because alias_method is private
  alias_method(n,m)    # make n an alias for m
}
end

backup(String, :reverse)
puts "test".o_reverse              #=> "tset"


# As we learned in Section 6.1.5, you can use the undef statement to undefine a method. This works only if you can express the name of a method as a hardcoded identifier in your program. If you need to dynamically delete a method whose name has been computed by your program, you have two choices: remove_method or undef_method. Both are private methods of Module. remove_method removes the definition of the method from the current class. If there is a version defined by a superclass, that version will now be inherited. undef_method is more severe; it prevents any invocation of the specified method through an instance of the class, even if there is an inherited version of that method. 

puts String.greet3 "xx"
String.singleton_class.class_eval { remove_method(:greet3) }
#puts String.greet3 "xx"


# 8.4.5. Handling Undefined Methods

# When the method name resolution algorithm (see Section 7.8) fails to find a method, it looks up a method named method_missing instead. When this method is invoked, the first argument is a symbol that names the method that could not be found. This symbol is followed by all the arguments that were to be passed to the original method. If there is a block associated with the method invocation, that block is passed to method_missing as well. 

# The default implementation of method_missing, in the Kernel module, simply raises a NoMethodError. This exception, if uncaught, causes the program to exit with an error message, which is what you would normally expect to happen when you try to invoke a method that does not exist. 

# Defining your own method_missing method for a class allows you an opportunity to handle any kind of invocation on instances of the class. The method_missing hook is one of the most powerful of Ruby's dynamic capabilities, and one of the most commonly used metaprogramming techniques. We'll see examples of its use later in this chapter. For now, the following example code adds a method_missing method to the Hash class. It allows us to query or set the value of any named key as if the key were the name of a method: 

class Hash

  def method_missing(key, *args)
    text = key.to_s
    if text[-1,1] == '='             # if key ends with = set a value
       self[text.chop.to_sym] = args[0]   # strip = from key
    else 
       self[key]                              #.. just return the key value
    end
  end
end

h = {}  #create an empty hash object
h.one = 1   # same as h[:one] = 1
puts h.one   # prints 1. same as puts h[:one]




# 8.4.6. Setting Method Visibility

# Section 7.2 introduced public, protected, and private. These look like language keywords but are actually private instance methods defined by Module. These methods are usually used as a static part of a class definition. But, with class_eval, they can also be used dynamically: 

String.class_eval { private :reverse }
#"hello".reverse # Not Method Error : private method 'reverse'


# private_class_method and public_class_method are similar, except that they operate on class methods and are themselves public: 

# Make all Math methods private
# Now we have to include math in order to invoke its methods
Math.private_class_method *Math.singleton_methods
# Math.sin(0)  # : private method `sin' called for Math:Module (NoMethodError)
