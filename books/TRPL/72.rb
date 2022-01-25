# -*- coding: utf-8 -*-


#7.2. Method Visibility: Public, Protected, Private

# Instance methods may be public, private, or protected. If you've programmed with other object-oriented languages, you may already be familiar with these terms. Pay attention anyway, because these words have a somewhat different meaning in Ruby than they do in other languages. 

# Methods are normally public unless they are explicitly declared to be private or protected. One exception is the initialize method, which is always implicitly private. Another exception is any "global" method declared outside of a class definition—those methods are defined as private instance methods of Object. A public method can be invoked from anywhere—there are no restrictions on its use. 

# A private method is internal to the implementation of a class, and it can only be called by other instance methods of the class (or, as we'll see later, its subclasses). Private methods are implicitly invoked on self, and may not be explicitly invoked on an object. If m is a private method, then you must invoke it in functional style as m. You cannot write o.m or even self.m. 

# A protected method is like a private method in that it can only be invoked from within the implementation of a class or its subclasses. It differs from a private method in that it may be explicitly invoked on any instance of the class, and it is not restricted to implicit invocation on self. A protected method can be used, for example, to define an accessor that allows instances of a class to share internal state with each other, but does not allow users of the class to access that state. 

# Protected methods are the least commonly defined and also the most difficult to understand. The rule about when a protected method can be invoked can be more formally described as follows: a protected method defined by a class C may be invoked on an object o by a method in an object p if and only if the classes of o and p are both subclasses of, or equal to, the class C. 

# Method visibility is declared with three methods named public, private, and protected. These are instance methods of the Module class. All classes are modules, and inside a class definition (but outside method definitions), self refers to class being defined. Thus, public, private, and protected may be used bare as if they were keywords of the language. In fact, however, they are method invocations on self. There are two ways to invoke these methods. With no arguments, they specify that all subsequent method definitions will have the specified visibility. A class might use them like this: 

class Point
  #public methods go here

  # The following methods are protected
  protected

  # protected methods go here

  # The following methods are private
  private

  # private methods go here

end


# The methods may also be invoked with the names of one or more methods (as symbols or strings) as arguments. When invoked like this, they alter the visibility of the named methods. In this usage, the visibility declaration must come after the definition of the method. One approach is to declare all private and protected methods at once, at the end of a class. Another approach is to declare the visibility of each private or protected method immediately after it is defined. Here, for example, is a class with a private utility method and a protected accessor method: 

class Widget
  def x
    @x = 9
  end
  protected :x   # make it protected

  def utility_method
    puts "utility_method"
  end
  private  :utility_method  # and make it private
end


# Remember that public, private, and protected apply only to methods in Ruby. Instance and class variables are encapsulated and effectively private, and constants are effectively public. There is no way to make an instance variable accessible from outside a class (except by defining an accessor method, of course). And there is no way to define a constant that is inaccessible to outside use. 

# Occasionally, it is useful to specify that a class method should be private. If your class defines factory methods, for example, you might want to make the new method private. To do this, use the private_class_method method, specifying one or more method names as symbols:

class Point2
  private_class_method :new
end

# Point2.new   #   private method `new' called for Point2:Class (NoMethodError)

# You can make a private class method public again with public_class_method. Neither method can be invoked without arguments in the way that public, protected, and private can be. 

# Ruby is, by design, a very open language. The ability to specify that some methods are private and protected encourages good programming style, and prevents inadvertent use of methods that are not part of the public API of a class

# It is important to understand, however, that Ruby's metaprogramming capabilities make it trivial to invoke private and protected methods and even to access encapsulated instance variables. To invoke the private utility method defined in the previous code, you can use the send method, or you can use instance_eval to evaluate a block in the context of the object: 

w = Widget.new              # create  a widget
w.send :utility_method   # invoke a private method!
w.instance_eval { utility_method }  #another way to invoke it
w.instance_eval { @x }  # read instance variable of w

# If you want to invoke a method by name, but you don't want to inadvertently invoke a private method that you don't know about, you can (in Ruby 1.9) use public_send instead of send. It works like send, but does not invoke private methods when called with an explicit receiver. public_send is covered in Chapter 8, as are send and instance_eval. 


