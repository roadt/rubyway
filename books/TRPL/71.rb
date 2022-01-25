# -*- coding: utf-8 -*-


# 7.1 Defining a Simple Class

#Ruby is an object-oriented language in a very pure sense: every value in Ruby is (or at least behaves like) an object. Every object is an instance of a class. A class defines a set of methods that an object responds to. Classes may extend or subclass other classes, and inherit or override the methods of their superclass. Classes can also include—or inherit methods from—modules. 

#Ruby's objects are strictly encapsulated: their state can be accessed only through the methods they define. The instance variables manipulated by those methods cannot be directly accessed from outside of the object. It is possible to define getter and setter accessor methods that appear to access object state directly. These pairs of accessor methods are known as attributes and are distinct from instance variables. The methods defined by a class may have "public," "protected," or "private" visibility, which affects how and where they may be invoked. 

#In contrast to the strict encapsulation of object state, Ruby's classes are very open. Any Ruby program can add methods to existing classes, and it is even possible to add "singleton methods" to individual objects. 

#Much of Ruby's OO architecture is part of the core language. Other parts, such as the creation of attributes and the declaration of method visibility, are done with methods rather than true language keywords.


=begin
This chapter begins with an extended tutorial that demonstrates how to define a class and add methods to it. This tutorial is followed by sections on more advanced topics, including: 

Method visibility

Subclassing and inheritance

Object creation and initialization

Modules, both as namespaces and as includable "mixins"

Singleton methods and the eigenclass

The method name resolution algorithm

The constant name resolution algorithm
=end


# 7.1.1 Creating the Class

class Point
end

# Like most Ruby constructs, a class definition is delimited with an end. In addition to defining a new class, the class keyword creates a new constant to refer to the class. The class name and the constant name are the same, so all class names must begin with a capital letter. 

# Within the body of a class, but outside of any instance methods defined by the class, the self keyword refers to the class being defined. 

# Like most statements in Ruby, class is an expression. The value of a class expression is the value of the last expression within the class body. Typically, the last expression within a class is a def statement that defines a method. The value of a def statement is always nil. 


# 7.1.2 Instantiating a Point

# Even though we haven't put anything in our Point class yet, we can still instantiate it: 
p = Point.new

puts Point
# The constant Point holds a class object that represents our new class. All class objects have a method named new that creates a new instance. 
#We can't do anything very interesting with the newly created Point object we've stored in the local variable p, because we haven't yet defined any methods for the class. We can, however, ask the new object what kind of object it is: 

p.class   # => Point
p.is_a? Point  #=> true



# 7.1.3 Initializing a Point

# When we create new Point objects, we want to initialize them with two numbers that represent their X and Y coordinates. In many object-oriented languages, this is done with a "constructor." In Ruby, it is done with an initialize method: 


class Point
  def initialize(x,y)
    @x,@y = x,y
  end
end

# This is only three new lines of code, but there are a couple of important things to point out here. 
#  When def is used like this with an unqualified method name inside of a class definition, it defines an instance method for the class. An instance method is a method that is invoked on an instance of the class. When an instance method is called, the value of self is an instance of the class in which the method is defined. 

puts  p = Point.new(0,0)

# In addition to being automatically invoked by Point.new, the initialize method is automatically made private. An object can call initialize on itself, but you cannot explicitly call initialize on p to reinitialize its state. 

# The instance variables of an object can only be accessed by the instance methods of that object. Code that is not inside an instance method cannot read or set the value of an instance variable (unless it uses one of the reflective techniques that are described in Chapter 8). 

# Instance variables are always resolved in the context of self. When the initialize method is invoked, self holds an instance of the Point class. But the code outside of that method is executed as part of the definition of the Point class. When those first two assignments are executed, self refers to the Point class itself, not to an instance of the class. The @x and @y variables inside the initialize method are completely different from those outside it. 


# 7.1.4 Defining a to_s Method

#Just about any class you define should have a to_s instance method to return a string representation of the object. This ability proves invaluable when debugging. Here's how we might do this for Point: 

class Point 
  def initialize(x,y)
    @x,@y = x,y
  end

  def to_s # return a string taht represents this point
    "(#@x,#@y)"     # now initalize previously created @x and @y
  end

end

# With this new method defined, we can create points and print them out: 
p = Point.new(1,2) # create a new Point object
puts p  # Displays "(1,2)"


# 7.1.5 Accessors and Attributes

# Our Point class uses two instance variables. As we've noted, however, the value of these variables are only accessible to other instance methods. If we want users of the Point class to be able to use the X and Y coordinates of a point, we've got to provide accessor methods that return the value of the variables: 

class Point
  def initialize(x,y)
    @x,@y = x,y
  end

  def x 
    @x
  end

  def y
    @y
  end
end

puts p = Point.new(1,2)
puts q = Point.new(p.x*2,p.y*3)

#The expressions p.x and p.y may look like variable references, but they are, in fact, method invocations without parentheses. 
#If we wanted our Point class to be mutable (which is probably not a good idea), we would also add setter methods to set the value of the instance variables: 

class MutablePoint
  def initialize(x,y); @x,@y = x,y;      end

  def x; @x; end   # getter for @x
  def y; @y; end  # getter for @y
    
  def x=(value)  # setter for @x 
    @x = value
  end
  
  def y=(value)
    @y = value
  end
  
end

# Recall that assignment expressions can be used to invoke setter methods like these. So with these methods defined, we can write: 

p = MutablePoint.new(1,1)
p.x = 0
p.y = 0


=begin
Using Setters Inside a Class
Once you've defined a setter method like x= for your class, you might be tempted to use it within other instance methods of your class. That is, instead of writing @x=2, you might write x=2, intending to invoke x=(2) implicitly on self. It doesn't work, of course; x=2 simply creates a new local variable. 
This is a not-uncommon mistake for novices who are just learning about setter methods and assignment in Ruby. The rule is that assignment expressions will only invoke a setter method when invoked through an object. If you want to use a setter from within the class that defines it, invoke it explicitly through self. For example: self.x=2. 
=end

#This combination of instance variable with trivial getter and setter methods is so common that Ruby provides a way to automate it. The attr_reader and attr_accessor methods are defined by the Module class. 
# All classes are modules, (the Class class is a subclass of Module) so you can invoke these method inside any class definition. Both methods take any number of symbols naming attributes. attr_reader creates trivial getter methods for the instance variables with the same name. attr_accessor creates getter and setter methods


# Thus, if we were defining a mutable Point class, we could write: 

class Point
  attr_accessor :x, :y   #define accessor methods for our instance variables
end

# And if we were defining an immutable version of the class, we'd write: 
class Point
  attr_reader :x,:y  # define reader methods for our instance variables
end

# Each of these methods can accept an attribute name or names as a string rather than as a symbol. The accepted style is to use symbols, but we can also write code like this:      attr_reader "x", "y"

=begin
attr is a similar method with a shorter name but with behavior that differs in Ruby 1.8 and Ruby 1.9. In 1.8, attr can define only a single attribute at a time. With a single symbol argument, it defines a getter method. If the symbol is followed by the value true, then it defines a setter method as well: 
attr :x        # Define a trivial getter method x for @x
attr :y, true  # Define getter and setter methods for @y

In Ruby 1.9, attr can be used as it is in 1.8, or it can be used as a synonym for attr_reader. 
=end


# The attr, attr_reader, and attr_accessor methods create instance methods for us. This is an example of metaprogramming, and the ability to do it is a powerful feature of Ruby. There are more examples of metaprogramming in Chapter 8. Note that attr and its related methods are invoked within a class definition but outside of any method definitions. They are only executed once, when the class is being defined. There are no efficiency concerns here: the getter and setter methods they create are just as fast as handcoded ones. Remember that these methods are only able to create trivial getters and setters that map directly to the value of an instance variable with the same name. If you need more complicated accessors, such as setters that set a differently named variable, or getters that return a value computed from two different variables, then you'll have to define those yourself. 

# 7.1.6 Defining Operators

# We'd like the + operator to perform vector addition of two Point objects, the * operator to multiply a Point by a scalar, and the unary – operator to do the equivalent of multiplying by –1. Method-based operators such as + are simply methods with punctuation for names. Because there are unary and binary forms of the – operator, Ruby uses the method name –@ for unary minus. Here is a version of the Point class with mathematical operators defined: 

class Point
  attr_reader :x,:y

  def initialize(x,y)
    @x,@y = x,y
  end

  def +(other)
    Point.new(@x+other.x,@y+other.y)
  end
  
  def -@
    Point.new(-@x,-@y)
  end

  def *(scalar)
    Point.new(@x*scalar,@y*scalar)
  end
end


puts p1 = Point.new(1,2)
puts p2 = Point.new(2,2)
puts p1+p2
puts -p2
puts p1*3


# Take a look at the body of the + method. It is able to use the @x instance variable of self—the object that the method is invoked on. But it cannot access @x in the other Point object. Ruby simply does not have a syntax for this; all instance variable references implicitly use self. Our + method, therefore, is dependent on the x and y getter methods. (We'll see later that it is possible to restrict the visibility of methods so that objects of the same class can use each other's methods, but code outside the class cannot use them.) 


=begin
Type Checking and Duck Typing
Our + method does not do any type checking; it simply assumes that it has been passed a suitable object. It is fairly common in Ruby programming to be loose about the definition of "suitable." In the case of our + method, any object that has methods named x and y will do, as long as those methods expect no arguments and return a number of some sort. We don't care if the argument actually is a point, as long as it looks and behaves like a point. This approach is sometimes called "duck typing," after the adage "if it walks like a duck and quacks like a duck, it must be a duck." 
If we pass an object to + that is not suitable, Ruby will raise an exception. Attempting to add 3 to a point, for example, results in this error message: 
NoMethodError: undefined method `x' for 3:Fixnum
        from ./point.rb:37:in `+'

Translated, this tells us that the Fixnum 3 does not have a method named x, and that this error arose in the + method of the Point class. This is all the information we need to figure out the source of the problem, but it is somewhat obscure. Checking the class of method arguments may make it easier to debug code that uses that method. Here is a version of the method with class verification: 
def +(other)
  raise TypeError, "Point argument expected" unless other.is_a? Point
  Point.new(@x + other.x, @y + other.y)
end

Here is a looser version of type checking that provides improved error messages but still allows duck typing: 
def +(other)
  raise TypeError, "Point-like argument expected" unless
    other.respond_to? :x and other.respond_to? :y
  Point.new(@x + other.x, @y + other.y)
end

Note that this version of the method still assumes that the x and y methods return numbers. We'd get an obscure error message if one of these methods returned a string, for example. 
Another approach to type checking occurs after the fact. We can simply handle any exceptions that occur during execution of the method and raise a more appropriate exception of our own: 
def +(other)         # Assume that other looks like a Point
  Point.new(@x + other.x, @y + other.y)
rescue               # If anything goes wrong above
  raise TypeError,   # Then raise our own exception
    "Point addition with an argument that does not quack like a Point!"
end
=end

# Note that our * method expects a numeric operand, not a Point. If p is point, then we can write p*2. As our class is written, however, we cannot write 2*p. That second expression invokes the * method of the Integer class, which doesn't know how to work with Point objects. Because the Integer class doesn't know how to multiply by a Point, it asks the point for help by calling its coerce method. (See Section 3.8.7.4 for more details.) If we want the expression 2*p to return the same result as p*2, we can define a coerce method: 

# If we try passing a Point to the * method of an Integer, it will call
# this method on the Point and then will try to multiply the elements of 
# the array. Instead of doing type conversion, we switch the order of
# the operands, so that we invoke the * method defined above.
class Point
  def coerce(other)  
    [self,other]
  end

  def to_s
    "Point(#@x,#@y)"
  end
end

puts 3*p2
puts p1*p2


# 7.17. Array and Hash Acess with []

#Ruby uses square brackets for array and hash access, and allows any class to define a [] method and use these brackets itself.

##Let's define a [] method for our class to allow Point objects to be treated as read-only arrays of length 2, or as read-only hashes with keys :x and :y: 
class Point
  def [](index)
    case index
    when 0,-2 then @x
    when 1, -1 then @y
    when :x , "x" then @x
    when :y , "y" then  @y
    else nil
    end
  end
end
                                            
print p1[0],p1[-2],p1[1],p1[-1],p1[:x],p1[:y],p1['x'],p1['y']
puts p1[:t],p1['s']


# 7.1.8 Enmerating Coordinates

# If a Point object can behave like an array with two elements, then perhaps we ought to be able to iterate through those elements as we can with a true array. Here is a definition of the each iterator for our Point class. Because a Point always has exactly two elements, our iterator doesn't have to loop; it can simply call yield twice:

class Point
  def each
    yield @x
    yield @y
  end
end

#With this iterator defined, we can write code like this: 
p = Point.new(1,2)
p.each{|x| puts x}

class Point
  include Enumerable
end

print p.all? {|x| x==0}   # true if the block is true for all elemetns
puts p.all? {|x| x==1 or x==2}  


# 7.1.9 Point Equality

p1 = Point.new(1,2)
p2 = Point.new(1,2)
print p1== p2

class Point
  def ==(o)
    if o.is_a? Point
      @x == o.x && @y == o.y
    elsif
      false
    end
  end
end

puts p1 == p2




=begin
Duck Typing and Equality
The + operator we defined earlier did no type checking at all: it works with any argument object with x and y methods that return numbers. This == method is implemented differently; instead of allowing duck typing, it requires that the argument is a Point. This is an implementation choice. The implementation of == above chooses to define equality so that an object cannot be equal to a Point unless it is itself a Point. 
Implementations may be stricter or more liberal than this. The implementation above uses the is_a? predicate to test the class of the argument. This allows an instance of a subclass of Point to be equal to a Point. A stricter implementation would use instance_of? to disallow subclass instances. Similarly, the implementation above uses == to compare the X and Y coordinates. For numbers, the == operator allows type conversion, which means that the point (1,1) is equal to (1.0,1.0). This is probably as it should be, but a stricter definition of equality could use eql? to compare the coordinates. 
A more liberal definition of equality would support duck typing. Some caution is required, however. Our == method should not raise a NoMethodError if the argument object does not have x and y methods. Instead, it should simply return false: 
def ==(o)                  # Is self == o?
  @x == o.x && @y == o.y   # Assume o has proper x and y methods
rescue                     # If that assumption fails
  false                    # Then self != o
end

Recall from Section 3.8.5 that Ruby objects also define an eql? method for testing equality. By default, the eql? method, like the == operator, tests object identity rather than equality of object content. Often, we want eql? to work just like the == operator, and we can accomplish this with an alias:
 
class Point
  alias eq? ==
end

On the other hand, there are two reasons we might want eql? to be different from ==. First, some classes define eql? to perform a stricter comparison than ==. In Numeric and its subclasses, for example, == allows type conversion and eql? does not. If we believe that the users of our Point class might want to be able to compare instances in two different ways, then we might follow this example. Because points are just two numbers, it would make sense to follow the example set by Numeric here. Our eql? method would look much like the == method, but it would use eql? to compare point coordinates instead of ==: 

=end

print p1.eql? p2

class Point
  def eql?(o)             
    if o.instance_of? Point      
      @x.eql?(o.x) && @y.eql?(o.y)
    elsif
      false
    end
  end

#  alias === eql?
end

print p1.eql? p2
puts p1 === p2

=begin
As an aside, note that this is the right approach for any classes that implement collections (sets, lists, trees) of arbitrary objects. The == operator should compare the members of the collection using their == operators, and the eql? method should compare the members using their eql? methods. 
The second reason to implement an eql? method that is different from the == operator is if you want instances of your class to behave specially when used as a hash key. The Hash class uses eql? to compare hash keys (but not values). If you leave eql? undefined, then hashes will compare instances of your class by object identity. This means that if you associate a value with a key p, you will only be able to retrieve that value with the exact same object p. An object q won't work, even if p == q. Mutable objects do not work well as hash keys, but leaving eql? undefined neatly sidesteps the problem. (See Section 3.4.2 for more on hashes and mutable keys.) 
Because eql? is used for hashes, you must never implement this method by itself. If you define an eql? method, you must also define a hash method to compute a hashcode for your object. If two objects are equal according to eql?, then their hash methods must return the same value. (Two unequal objects may return the same hashcode, but you should avoid this to the extent possible.) 
Implementing optimal hash methods can be very tricky. Fortunately, there is a simple way to compute perfectly adequate hashcodes for just about any class: simply combine the hashcodes of all the objects referenced by your class. (More precisely: combine the hashcodes of all the objects compared by your eql? method.) The trick is to combine the hashcodes in the proper way. The following hash method is not a good one: 
=end

class Point
  def hash
    @x.hash + @y.hash    
  end

end

# The problem with this method is that it returns the same hashcode for the point (1,0) as it does for the point (0,1). This is legal, but it leads to poor performance when points are used as hash keys. Instead, we should mix things up a bit: 

class Point
  def hash
    code = 17
    code = 37*code +@x.hash
    code = 37*code + @y.hash
    # add more for each significant instance variables
    code
  end
  
end

#This general-purpose hashcode recipe should be suitable for most Ruby classes. It, and its constants 17 and 37, are adapted from the book Effective Java by Joshua Bloch (Prentice Hall). 


# 7.1.10  Ordering Points


=begin

Suppose we wish to define an ordering for Point objects so that we can compare them and sort them. There are a number of ways to order points, but we'll chose to arrange them based on their distance from the origin. This distance (or magnitude) is computed by the Pythagorean theorem: the square root of the sum of the squares of the X and Y coordinates. 
To define this ordering for Point objects, we need only define the <=> operator (see Section 4.6.6) and include the Comparable module. Doing this mixes in implementations of the equality and relational operators that are based on our implementation of the general <=> operator we defined. The <=> operator should compare self to the object it is passed. If self is less than that object (closer to the origin, in this case), it should return –1. If the two objects are equal, it should return 0. And if self is greater than the argument object, the method should return 1. (The method should return nil if the argument object and self are of incomparable types.) The following code is our implementation of <=>. There are two things to note about it. First, it doesn't bother with the Math.sqrt method and instead simply compares the sum of the squares of the coordinates. Second, after computing the sums of the squares, it simply delegates to the <=> operator of the Float class: 

=end

class Point
  include Comparable  # mix in methods from the Comparable module

  # Define an ordering for points based on their distance from the origin.
  # This method is required by the Comparable module.
  def <=>(other)
    return nil unless other.instance_of? Point
    @x**2+@y**2 <=> other.x**2 + other.y**2
  end
end

# Note that the Comparable module defines an == method that uses our definition of <=>. Our distance-based comparison operator results in an == method that considers the points (1,0) and (0,1) to be equal. Because our Point class explicitly defines its own == method, however, the == method of Comparable is never invoked. Ideally, the == and <=> operators should have consistent definitions of equality. This was not possible in our Point class, and we end up with operators that allow the following: 


p,q = Point.new(1,0), Point.new(0,1)
print p == q    #  return false. use explicit def ==(o) instance method.
print p<q
puts p> q

# Finally, It is worth noting here that the Enumerable module defines several methods, such as sort, min, and max, that only work if the objects being enumerated define the <=> operator. 
print p1.min,p1.max
puts p.sort




# 7.1.11 A Mutable Point

#The Point class we've been developing is immutable: once a point object has been created, there is no public API to change the X and Y coordinates of that point. This is probably as it should be. But let's detour and investigate some methods we might add if we wanted points to be mutable. 

#First of all, we'd need x= and y= setter methods to allow the X and Y coordinates to be set directly. We could define these methods explicitly, or simply change our attr_reader line to attr_accessor: 

class MutablePoint
  attr_accessor :x, :y
end

# Next, we'd like an alternative to the + operator for when we want to add the coordinates of point q to the coordinates of point p, and modify point p rather than creating and returning a new Point object. We'll call this method add!, with the exclamation mark indicating that it alters the internal state of the object on which it is invoked: 

class MutablePoint
  def add!(p)  # add p to self, return modified self
    @x += p.x
    @y += p.y
    self
  end  
end

# When defining a mutator method, we normally only add an exclamation mark to the name if there is a nonmutating version of the same method. In this case, the name add! makes sense if we also define an add method that returns a new object, rather than altering its receiver. A nonmutating version of a mutator method is often written simply by creating a copy of self and invoking the mutator on the copied object: 
class MutablePoint
  def add(p)  # a non mutating version of add!
    q = self.dup  # make a copy of self
    q.add!(p)   # invoke the mutating method on the copy
  end
end

# In this trivial example, our add method works just like the + operator we've already defined, and it's not really necessary. So if we don't define a nonmutating add, we should consider dropping the exclamation mark from add! and allowing the name of the method itself ("add" instead of "plus") to indicate that it is a mutator. 




# 7.1.12  Quck and Easy Mutable Classes

# If you want a mutable Point class, one way to create it is with Struct. Struct is a core Ruby class that generates other classes. These generated classes have accessor methods for the named fields you specify. There are two ways to create a new class with Struct.new: 

Struct.new("Point", :x, :y)  # creates new class Struct::Point
SPoint = Struct.new(:x, :y)  # creates new class, assigns to Point

=begin
Naming Anonymous Classes

The second line in the code relies on a curious fact about Ruby classes: if you assign an unnamed class object to a constant, the name of that constant becomes the name of a class. You can observe this same behavior if you use the Class.new constructor: 

C = Class.new   # A new class with no body, assigned to a constant
c = C.new       # Create an instance of the class
c.class.to_s    # => "C": constant name becomes class name
=end


# Once a class has been created with Struct.new, you can use it like any other class. Its new method will expect values for each of the named fields you specify, and its instance methods provide read and write accessors for those fields: 

p = SPoint.new(1,2)  # => #<struct Point x=1, y=2>
print p.x, p.y, p.x=3, p.x,"\n"

# Structs also define the [] and []= operators for array and hash-style indexing, and even provide each and each_pair iterators for looping through the values held in an instance of the struct: 
print p[:x],p[:x]=4,p[:x],p[1],"\n"
p.each{|c| print c}
p.each_pair{|n,c| print n,c}

# Struct-based classes have a working == operator, can be used as hash keys (though caution is necessary because they are mutable), and even define a helpful to_s method: 


q = SPoint.new(4,2)
puts q == p
print h = {q=>1}, h[p],q.to_s , "\n"

# A Point class defined as a struct does not have point-specific methods like add! or the <=> operator defined earlier in this chapter. There is no reason we can't add them, though. Ruby class definitions are not static. Any class (including classes defined with Struct.new) can be "opened" and have methods added to it. Here's a Point class initially defined as a Struct, with point-specific methods added: 

class SPoint
  def add!(other)
    self.x += other.x
    self.y += other.y
    self
  end

  include Comparable
  def <=>(o)
    return nil unless o.instance_of? SPoint
    self.x**2 +self.y**2 <=> o.x**2 + o.y**2
  end
end

print p == q, p.add!(q), p==q, "\n"

# As noted at the beginning of this section, the Struct class is designed to create mutable classes. With just a bit of work, however, we can make a Struct-based class immutable: 

class SPoint   # open the class
  undef x=,y=,[]=   # undefine mutator methods
end

# p.x = 1  #   error now.



#7.1.13 A Class Method

=begin
Let's take another approach to adding Point objects together. Instead of invoking an instance method of one point and passing another point to that method, let's write a method named sum that takes any number of Point objects, adds them together, and returns a new Point. This method is not an instance method invoked on a Point object. Rather, it is a class method, invoked through the Point class itself. We might invoke the sum method like this: 

total = Point.sum(p1, p2, p3)  # p1, p2 and p3 are Point objects

Keep in mind that the expression Point refers to a Class object that represents our point class. To define a class method for the Point class, what we are really doing is defining a singleton method of the Point object. (We covered singleton methods in Section 6.1.4.) To define a singleton method, use the def statement as usual, but specify the object on which the method is to be defined as well as the name of the method. Our class method sum is defined like this: 
=end

class Point
  attr_reader :x, :y

  def Point.sum(*points)
    x = y = 0
    points.each{|p| x+=p.x; y+=p.y}
    Point.new(x,y)
  end
end

puts Point.sum(p1,p2, p1*3)



# This definition of the class method names the class explicitly, and mirrors the syntax used to invoke the method. Class methods can also be defined using self instead of the class name. Thus, this method could also be written like this: 

class Point
  def self.sum2(*points)
    x=y=0
    points.each {|p| x+=p.x;y+=p.y}
    Point.new(x,y)
  end
end

puts Point.sum2(p1,p2,p1*3)

# Using self instead of Point makes the code slightly less clear, but it's an application of the DRY (Don't Repeat Yourself) principle. If you use self instead of the class name, you can change the name of a class without having to edit the definition of its class methods. 

# There is yet another technique for defining class methods. Though it is less clear than the previously shown technique, it can be handy when defining multiple class methods, and you are likely to see it used in existing code: 

class << Point        # syntax for adding mehtods to a single object
  def sum3(*points)
    x=y=0
    points.each {|p| x+=p.x;y+=p.y}
    Point.new(x,y)
  end

  # other class methdos can be defined here.
end

puts  Point.sum3(p1,p2,p1*3)

#This technique can also be used inside the class definition, where we can use self instead of repeating the class name: 

class Point
  # instance methods go here

  class << self
    #class methods go here
    def sum4(*points)
      x=y=0
      points.each {|p| x+=p.x;y+=p.y}
      Point.new(x,y)
    end
  end
end

puts Point.sum4(p1,p2, p1*3)

#We'll learn more about this syntax in Section 7.7. 

# 7.1.14 Constants

#Many classes can benefit from the definition of some associated constants. Here are some constants that might be useful for our Point class: 

class Point
  ORIGIN = Point.new(0,0)
  UNIT_X = Point.new(1,0)
  UNIT_Y = Point.new(0,1)
  # rest of class definition goes here.
end

# Inside the class definition, these constants can be referred to by their unqualified names. Outside the definition, they must be prefixed by the name of the class, of course: 
puts Point::UNIT_X + Point::UNIT_Y

# Note that because our constants in this example refer to instances of the class, we cannot define the constants until after we've defined the initialize method of the class. 

#Also, keep in mind that it is perfectly legal to define constants in the Point class from outside the class: 
Point::NEGATIVE_UNIT_X = Point.new(-1,0)


#7.1.15. Class variables

#Class variables are visible to, and shared by, the class methods and the instance methods of a class, and also by the class definition itself. Like instance variables, class variables are encapsulated; they can be used by the implementation of a class, but they are not visible to the users of a class. Class variables have names that begin with @@. 

##There is no real need to use class variables in our Point class, but for the purposes of this tutorial, let's suppose that we want to collect data about the number of Point objects that are created and their average coordinates. Here's how we might write the code: 

class Point
  @@n = 0                 
  @@totalX = 0
  @@totalY = 0
  
  def initialize(x,y)
    @x,@y = x,y
    
    @@n += 1
    @@totalX += x
    @@totalY += y
  end

  def self.report
    puts "Number of points craeted: #@@n"
    puts "Average X coordinate: #{@@totalX.to_f/@@n}"
    puts "Average Y corrdinate: #{@@totalY.to_f/@@n}"
  end
end

p1 =  Point.new(1,2)
p2 = Point.new(2,2)
p3 = Point.new(3,4)

Point.report

# The thing to notice about this code is that class variables are used in instance methods, class methods, and in the class definition itself, outside of any method. Class variables are fundamentally different than instance variables. We've seen that instance variables are always evaluated in reference to self. That is why an instance variable reference in a class definition or class method is completely different from an instance variable reference in an instance method. Class variables, on the other hand, are always evaluated in reference to the class object created by the enclosing class definition statement. 


# 7.116. Class Instance Variables
  
=begin
Classes are objects and can have instance variables just as other objects can. The instance variables of a class—often called class instance variables—are not the same as class variables. But they are similar enough that they can often be used instead of class variables. 
An instance variable used inside a class definition but outside an instance method definition is a class instance variable. Like class variables, class instance variables are associated with the class rather than with any particular instance of the class. A disadvantage of class instance variables is that they cannot be used within instance methods as class variables can. Another disadvantage is the potential for confusing them with ordinary instance variables. Without the distinctive punctuation prefixes, it may be more difficult to remember whether a variable is associated with instances or with the class object. 
One of the most important advantages of class instance variables over class variables has to do with the confusing behavior of class variables when subclassing an existing class. We'll return to this point later in the chapter. 
Let's port our statistics-gathering version of the Point class to use class instance variables instead of class variables. The only difficulty is that because class instance variables cannot be used from instance methods, we must move the statistics gathering code out of the initialize method (which is an instance method) and into the new class method used to create points: 

=end

class Point3
  # Initialize our class instance variables in the class definition itself
  @n = 0              # How many points have been created
  @totalX = 0         # The sum of all X coordinates
  @totalY = 0         # The sum of all Y coordinates
  def initialize(x,y) # Initialize method 
    @x,@y = x, y      # Sets initial values for instance variables
  end
  def self.new(x,y)   # Class method to create new Point objects
    # Use the class instance variables in this class method to collect data
    @n += 1           # Keep track of how many Points have been created
    @totalX += x      # Add these coordinates to the totals
    @totalY += y
    super             # Invoke the real definition of new to create a Point
                      # More about super later in the chapter
  end
  # A class method to report the data we collected
  def self.report
    # Here we use the class instance variables in a class method
    puts "Number of points created: #@n"
    puts "Average X coordinate: #{@totalX.to_f/@n}"
    puts "Average Y coordinate: #{@totalY.to_f/@n}"
  end
end

p1 = Point3.new(1,2)
p2 = Point3.new(2,2)
p3 = Point3.new(2,3)

 Point3.report


# Because class instance variables are just instance variables of class objects, we can use attr, attr_reader, and attr_accessor to create accessor methods for them. The trick, however, is to invoke these metaprogramming methods in the right context. Recall that one way to define class methods uses the syntax class << self. This same syntax allows us to define attribute accessor methods for class instance variables: 


class Point3
  
class << self
  attr_accessor :n, :totalX, :totalY
end
end

# With these accessors defined, we can refer to our raw data as Point.n, Point.totalX, and Point.totalY. 

print Point3.n, Point3.totalX, Point3.totalY, "\n"

