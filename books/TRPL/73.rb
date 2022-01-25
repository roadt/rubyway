# -*- coding: utf-8 -*-


# 7.3. Subclassing and Inheritance

# Most object-oriented programming languages, including Ruby, provide a subclassing mechanism that allows us to create new classes whose behavior is based on, but modified from, the behavior of an existing class. We'll begin this discussion of subclassing with definitions of basic terminology. If you've programmed in Java, C++, or a similar language, you are probably already familiar with these terms. 

# When we define a class, we may specify that it extends—or inherits from—another class, known as the superclass. If we define a class Ruby that extends a class Gem, we say that Ruby is a subclass of Gem, and that Gem is the superclass of Ruby. If you do not specify a superclass when you define a class, then your class implicitly extends Object. A class may have any number of subclasses, and every class has a single superclass except Object, which has none. 

# The fact that classes may have multiple subclasses but only a single superclass means that they can be arranged in a tree structure, which we call the Ruby class hierarchy. The Object class is the root of this hierarchy, and every class inherits directly or indirectly from it. The descendants of a class are the subclasses of the class plus the subclasses of the subclasses, and so on recursively. The ancestors of a class are the superclass, plus the superclass of the superclass, and so on up to Object. Figure 5-5 in Chapter 5 illustrates the portion of the Ruby class hierarchy that includes Exception and all of its descendants. In that figure, you can see that the ancestors of EOFError are IOError, StandardError, Exception, and Object. 

=begin

BasicObject in Ruby 1.9

In Ruby 1.9, Object is no longer the root of the class hierarchy. A new class named BasicObject serves that purpose, and Object is a subclass of BasicObject. BasicObject is a very simple class, with almost no methods of its own, and it is useful as the superclass of delegating wrapper classes (like the one shown in Example 8-5 in Chapter 8). 
When you create a class in Ruby 1.9, you still extend Object unless you explicitly specify the superclass, and most programmers will never need to use or extend BasicObject. 

=end


##The syntax for extending a class is simple. Just add a < character and the name of the superclass to your class statement. For example: 

class Point
  attr_accessor :x,:y

  def initialize(x,y)
    @x,@y = x,y
  end

  def to_s
    "[#@x,#@y]"
  end

  def self.sum(*points)
    x = y = 0
    points.each{|p| x+=p.x; y+=p.y}
    Point.new(x,y)
  end


  def self.po
    puts ORIGIN
  end

  ORIGIN = Point.new(0,0)
end

class Point3D < Point # define class Point3D as a subclass of Point
end


=begin

 Subclassing a Struct

Earlier in this chapter, we saw how to use Struct.new to automatically generate simple classes. It is also possible to subclass a struct-based class, so that methods other than the automatically generated ones can be added: 

=end

class Point3Da < Struct.new("Point3D", :x, :y, :z)
  # Superclass struct gives us accessor methods, ==, to_s, etc.
  # Add point-specific methods here
end


# 7.3.1 Inheriting Methods

# The Point3D class we have defined is a trivial subclass of Point. It declares itself an extension of Point, but there is no class body, so it adds nothing to that class. A Point3D object is effectively the same thing as a Point object. One of the only observable differences is in the value returned by the class method: 

p2 = Point.new(1,2)
p3 = Point3D.new(1,2)

print p2.to_s, p2.class,"\n"
print p3.to_s, p3.class,"\n"

# The value returned by the class method is different, but what's more striking about this example is what is the same. Our Point3D object has inherited the to_s method defined by Point. It has also inherited the initialize method—this is what allows us to create a Point3D object with the same new call that we use to create a Point object.[*] There is another example of method inheritance in this code: both Point and Point3D inherit the class method from Object.

# [*] If you're a Java programmer, this may be surprising to you. Java classes define special constructor methods for initialization, and those methods are not inherited. In Ruby, initialize is an ordinary method and is inherited like any other.

# 7.3.2 Overriding Methods

# When we define a new class, we add new behavior to it by defining new methods. Just as importantly, however, we can customize the inherited behavior of the class by redefining inherited methods. 

o = Object.new
puts o.to_s

# When we defined a to_s method in the Point class, we were overriding the to_s method inherited from Object. 
# One of the important things to understand about object-oriented programming and subclassing is that when methods are invoked, they are looked up dynamically so that the appropriate definition or redefinition of the method is found. That is, method invocations are not bound statically at the time they are parsed, but rather, are looked up at the time they are executed. Here is an example to demonstrate this important point: 

#Greet the World

class WorldGreeter
  def greet
    puts "#{greeting} #{who}"
  end
  
  def greeting
    "Hello"
  end

  def who
    "World"
  end
end

# Greet the world in Spanish
class SpanishWorldGreeter < WorldGreeter
  def greeting  # override the greeting
    "Hola"
  end
end

# We call a method defined in WorldGreeter, which calls the overridden
# version of greeting in SpanishWorldGreeter, and prints "Hola World"
SpanishWorldGreeter.new.greet

# If you've done object-oriented programming before, the behavior of this program is probably obvious and trivial to you. But if you're new to it, it may be profound. We call the greet method inherited from WorldGreeter. This greet method calls the greeting method. At the time that greet was defined, the greeting method returned "Hello". But we've subclassed WorldGreeter, and the object we're calling greet on has a new definition of greeting. When we invoke greeting, Ruby looks up the appropriate definition of that method for the object it is being invoked on, and we end up with a proper Spanish greeting rather than an English one. This runtime lookup of the appropriate definition of a method is called method name resolution, and is described in detail in Section 7.8 at the end of this chapter. 

# Notice that it is also perfectly reasonable to define an abstract class that invokes certain undefined "abstract" methods, which are left for subclasses to define. The opposite of abstract is concrete. A class that extends an abstract class is concrete if it defines all of the abstract methods of its ancestors. For example: 

class AbstractGreeter
  def greet
    puts "#{greeting} #{who}"
  end
end

# A concrete subclass
class WorldGreeterA < AbstractGreeter
  def greeting; "Hello"; end
  def who; "World"; end
end

WorldGreeterA.new.greet   # Displays "Hello World"


#7.3.2.1. Overriding private methods


# Private methods cannot be invoked from outside the class that defines them. But they are inherited by subclasses. This means that subclasses can invoke them and can override them. 

class A
  private
  def prm
    puts "A::private method"
  end
end

class B < A
  def pum
    prm
  end
end
B.new.pum

# Be careful when you subclass a class that you did not write yourself. Classes often use private methods as internal helper methods. They are not part of the public API of the class and are not intended to be visible. If you haven't read the source code of the class, you won't even know the names of the private methods it defines for its own use. If you happen to define a method (whatever its visibility) in your subclass that has the same name as a private method in the superclass, you will have inadvertently overridden the superclass's internal utility method, and this will almost certainly cause unintended behavior. 

class B
  def prm
    puts "private? i'm B::prm"
  end
end
B.new.pum

# The upshot is that, in Ruby, you should only subclass when you are familiar with the implementation of the superclass. If you only want to depend on the public API of a class and not on its implementation, then you should extend the functionality of the class by encapsulating and delegating to it, not by inheriting from it. 

# 7.3.3 Augmenting Behavior by Chaining

=begin

Sometimes when we override a method, we don't want to replace it altogether, we just want to augment its behavior by adding some new code. In order to do this, we need a way to invoke the overridden method from the overriding method. This is known as chaining, and it is accomplished with the keyword super. 

super works like a special method invocation: it invokes a method with the same name as the current one, in the superclass of the current class. (Note that the superclass need not define that method itself—it can inherit it from one of its ancestors.) You may specify arguments for super just as you would for a normal method invocation. One common and important place for method chaining is the initialize method of a class. Here is how we might write the initialize method of our Point3D class: 

=end

class Point3D < Point
  def initialize(x,y,z)
    # pass our first two arguments along to the superlcass initialize method
    super(x,y)
    # and deal with the third argument ourself.
    @z = z
  end
end


# If you use super as a bare keyword—with no arguments and no parentheses—then all of the arguments that were passed to the current method are passed to the superclass method. Note, however, that it's the current values of the method parameters that are passed to the superclass method. If the method has modified the values in its parameter variables, then the modified values are passed to the invocation of the superclass method. As with normal method invocations, the parentheses around super arguments are optional. Because a bare super has special meaning, however, you must explicitly use a pair of empty parentheses if you want to pass zero arguments from a method that itself has one or more arguments. 



# 7.3.4 Inheritance of Class Methods
  
# Class methods may be inherited and overridden just as instance methods can be. If our Point class defines a class method sum, then our Point3D subclass inherits that method. That is, if Point3D does not define its own class method named sum, then the expression Point3D.sum invokes the same method as the expression Point.sum. 

p1 = Point.new(1,2)
p2 = Point.new(2,1)
puts Point3D.sum(p1,p2)
# As a stylistic matter, it is preferable to invoke class methods through the class object on which they are defined. A code maintainer seeing an expression Point3D.sum would go looking for a definition of the sum method in the Point3D class, and he might have a hard time finding it in the Point class. When invoking a class method with an explicit receiver, you should avoid relying on inheritance—always invoke the class method through the class that defines it.[*]
# [*] The Class.new method is an exception—it is inherited by and invoked on just about every new class we define.

# Within the body of a class method, you may invoke the other class methods of the class without an explicit receiver—they are invoked implicitly on self, and the value of self in a class method is the class on which it was invoked. It is here, inside the body of a class method, that the inheritance of class methods is useful: it allows you to implicitly invoke a class method even when that class method is defined by a superclass. 

# Finally, note that class methods can use super just as instance methods can to invoke the same-named method in the superclass. 


# 7.3.5 Inheritance and Instance Variables

# Instance variables often appear to be inherited in Ruby. Consider this code, for example

class Point3D
  def to_s
    "(#@x, #@y, #@z)"  # variables @x and @y inherited
  end
end

# Instance variables often appear to be inherited in Ruby. Consider this code, for example

Point3D.new(1,2,3).to_s  # => "(1,2,3)"

# Because this code behaves as expected, you may be tempted to say that these variables are inherited. That is not how Ruby works, though. All Ruby objects have a set of instance variables. These are not defined by the object's class—they are simply created when a value is assigned to them. Because instance variables are not defined by a class, they are unrelated to subclassing and the inheritance mechanism. 

# In this code, Point3D defines an initialize method that chains to the initialize method of its superclass. The chained method assigns values to the variables @x and @y, which makes those variables come into existence for a particular instance of Point3D. 

# Programmers coming from Java—or from other strongly typed languages in which a class defines a set of fields for its instances—may find that this takes some getting used to. Really, though, it is quite simple: Ruby's instance variables are not inherited and have nothing to do with the inheritance mechanism. The reason that they sometimes appear to be inherited is that instance variables are created by the methods that first assign values to them, and those methods are often inherited or chained. 

# There is an important corollary. Because instance variables have nothing to do with inheritance, it follows that an instance variable used by a subclass cannot "shadow" an instance variable in the superclass. If a subclass uses an instance variable with the same name as a variable used by one of its ancestors, it will overwrite the value of its ancestor's variable. This can be done intentionally, to alter the behavior of the ancestor, or it can be done inadvertently. In the latter case, it is almost certain to cause bugs. As with the inheritance of private methods described earlier, this is another reason why it is only safe to extend Ruby classes when you are familiar with (and in control of) the implementation of the superclass. 

# Finally, recall that class instance variables are simply instance variables of the Class object that represents a class. As such, they are not inherited. Furthermore, the Point and Point3D objects (we're talking about the Class objects themselves, not the classes they represent) are both just instances of Class. There is no relationship between them, and no way that one could inherit variables from the other. 

#7.3.6. Inheritance and Class Variables

# Class variables are shared by a class and all of its subclasses. If a class A defines a variable @@a, then subclass B can use that variable. Although this may appear, superficially, to be inheritance, is it actually something different. 

# The difference becomes clear when we think about setting the value of a class variable. If a subclass assigns a value to a class variable already in use by a superclass, it does not create its own private copy of the class variable, but instead alters the value seen by the superclass. It also alters the shared value seen by all other subclasses of the superclass. Ruby 1.8 prints a warning about this if you run it with -w. Ruby 1.9 does not issue this warning.

# If a class uses class variables, then any subclass can alter the behavior of the class and all its descendants by changing the value of the shared class variable. This is a strong argument for the use of class instance variables instead of class variables. 

## The following code demonstrates the sharing of class variables. It outputs 123: 
class A
  @@value = 1
  def A.value; @@value; end
end
print A.value                               # display value of A's class variable
class B < A; @@value = 2; end   # subclass alters shared class variable
print A.value                               #superclass sees altered value
class C < A; @@value = 3; end  # another alters shared variable again
print B.value                                # 1st subclass sees value from 2nd subclass

#7.3.7 inheritance of constants 

# Constants are inherited and can be overridden, much like instance methods can.
#  There is, however, a very important difference between the inheritance of methods and the inheritance of constants. 


# Our Point3D class can use the ORIGIN constant defined by its Point superclass, for example. Although the clearest style is to qualify constants with their defining class, Point3D could also refer to this constant with an unqualified ORIGIN or even as Point3D::ORIGIN. Where inheritance of constants becomes interesting is when a class like Point3D redefines a constant. A three-dimensional point class probably wants a constant named ORIGIN to refer to a three-dimensional point, so Point3D is likely to include a line like this: 

class Point3D
  ORIGIN = Point3D.new(0,0,0)
end

Point3D.po   # -> [0,0] from Point.ORIGIN

class Point3D
  def self.po
    puts ORIGIN
  end
end

Point3D.po   # -> (0,0,0) from Point3D.ORIGIN

# As you know, Ruby issues a warning when a constant is redefined. In this case, however, this is a newly created constant. We now have two constants Point::ORIGIN and Point3D::ORIGIN. 

#  The important difference between constants and methods is that constants are looked up in the lexical scope of the place they are used before they are looked up in the inheritance hierarchy (Section 7.9 has details). This means that if Point3D inherits methods that use the constant ORIGIN, the behavior of those inherited methods will not change when Point3D defines its own version of ORIGIN.
