# -*- coding: utf-8 -*-


# 8.2.  Evaluating Strings and Blocks

#One of the most powerful and straightforward reflective features of Ruby is its eval method. If your Ruby program can generate a string of valid Ruby code, the Kernel.eval method can evaluate that code: 

x = 1
puts eval "x + 1"   # =>2

#eval is a very powerful function, but unless you are actually writing a shell program (like irb) that executes lines of Ruby code entered by a user you are unlikely to really need it. (And in a networked context, it is almost never safe to call eval on text received from a user, as it could contain malicious code.) Inexperienced programmers sometimes end up using eval as a crutch. If you find yourself using it in your code, see if there isn't a way to avoid it. Having said that, there are some more useful ways to use eval and eval-like methods. 


#8.2.1. Bindings and eval

#A Binding object represents the state of Ruby's variable bindings at some moment. The Kernel.binding object returns the bindings in effect at the location of the call. You may pass a Binding object as the second argument to eval, and the string you specify will be evaluated in the context of those bindings. If, for example, we define an instance method that returns a Binding object that represents the variable bindings inside an object, then we can use those bindings to query and set the instance variables of that object. We might accomplish this as follows: 

class Object # open object to add a new method
  def bindings  # note plural on this method
    binding  # this is the predefined kernel method
  end
end

class Test # A simple class with an instance variable
  def initialize(x); @x = x; end
end

print t = Test.new(10)   # create a test object
puts eval("@x", t.bindings)  # => 10: We've peeked inside it.


# Note that it is not actually necessary to define an Object.bindings method of this sort to peek at the instance variables of an object. Several other methods described shortly offer easier ways to query (and set) the value of the instance variables of an object. 

# As described in Section 6.6.2, the Proc object defines a public binding method that returns a Binding object representing the variable bindings in effect for the body of that Proc. Furthermore, the eval method allows you to pass a Proc object instead of a Binding object as the second argument. 

# Ruby 1.9 defines an eval method on Binding objects, so instead of passing a Binding as the second argument to the global eval, you can instead invoke the eval method on a Binding. Which one you choose is purely a stylistic matter; the two techniques are equivalent. 

#8.2.2. instance_eval and class_eval

#The Object class defines a method named instance_eval, and the Module class defines a method named class_eval. (module_eval is a synonym for class_eval.) Both of these methods evaluate Ruby code, like eval does, but there are two important differences. The first difference is that they evaluate the code in the context of the specified object or in the context of the specified module—the object or module is the value of self while the code is being evaluated. Here are some examples: 

puts t.instance_eval("@x")  # return value of o'instance variable @x

# Define an instance method len of String to return string length
String.class_eval("def len; size; end")
puts "test".len

# Here's another way to do that
# The quoted code behaves just as if it was inside "class String" and "end"
String.class_eval("alias len2 size")
puts "test".len2

# Use instance_eval to define class method String.empty
# Note that quotes within quotes get a little tricky...
String.instance_eval("def empty; ''; end")

# Note the subtle but crucial difference between instance_eval and class_eval when the code being evaluated contains a method definition. instance_eval defines singleton methods of the object (and this results in class methods when it is called on a class object). class_eval defines regular instance methods. 

# The second important difference between these two methods and the global eval is that instance_eval and class_eval can accept a block of code to evaluate. When passed a block instead of a string, the code in the block is executed in the appropriate context. Here, therefore, are alternatives to the previously shown invocations: 

print t.instance_eval { @x }
String.class_eval {
  def len3
    size
  end
}
String.class_eval  { alias len4 size }
String.instance_eval { def empty2; ""; end }
print  "t".len3, "t".len4,[ String.empty2], "\n"


#8.2.3. instance_exec and class_exec

# Ruby 1.9 defines two more evaluation methods: instance_exec and class_exec (and its alias, module_exec). These methods evaluate a block (but not a string) of code in the context of the receiver object, as instance_eval and class_eval do. The difference is that the exec methods accept arguments and pass them to the block. Thus, the block of code is evaluated in the context of the specified object, with parameters whose values come from outside the object. 


# end




