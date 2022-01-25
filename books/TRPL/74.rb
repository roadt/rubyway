# -*- coding: utf-8 -*-


#7.4. Object Creation and Initialization

# Objects are typically created in Ruby by calling the new method of their class. This section explains exactly how that works, and it also explains other mechanisms (such as cloning and unmarshaling) that create objects. Each subsection explains how you can customize the initialization of the newly created objects. 

#7.4.1. new, allocate, and initialize

# Every class inherits the class method new. This method has two jobs: it must allocate a new object—actually bring the object into existence—and it must initialize the object. It delegates these two jobs to the allocate and initialize methods, respectively. 


##  If the new method were actually written in Ruby, it would look something like this: 
def new(*args)
  o = self.allocate  # create a new object of this class
  o.initialize(*args) # call the object's initiailzie method
  o
end

# allocate is an instance method of Class, and it is inherited by all class objects. Its purpose is to create a new instance of the class. You can call this method yourself to create uninitialized instances of a class. But don't try to override it; Ruby always invokes this method directly, ignoring any overriding versions you may have defined. 

# initialize is an instance method. Most classes need one, and every class that extends a class other than Object should use super to chain to the initialize method of the superclass. The usual job of the initialize method is to create instance variables for the object and set them to their initial values. Typically, the value of these instance variables are derived from the arguments that the client code passed to new and that new passed to initialize. initialize does not need to return the initialized object. In fact, the return value of initialize is ignored. Ruby implicitly makes the initialize method private, which means that you cannot explicitly invoke it on an object. 

=begin
Class::new and Class#new

Class defines two methods named new. One, Class#new, is an instance method, and the other, Class::new, is a class method (we use the disambiguating naming convention of the ri tool here). The first is the instance method that we've been describing here; it is inherited by all class objects, becoming a class method of the class, and is used to create and initialize new instances. 
The class method Class::new is the Class class' own version of the method, and it can be used to create new classes. 
=end

#7.4.2 Factory Methods

# It is often useful to allow instances of a class to be initialized in more than one way. You can often do this by providing parameter defaults on the initialize method. With an initialize method defined as follows, for example, you can invoke new with either two or three arguments: 

class Point
  #intialize a point with two or three coordinates
  def initialize(x,y,z=nil)
    @x,@y,@z = x,y,z
  end

  attr_accessor :x,:y,:z

end

puts Point.new(1,2)
# Sometimes, however, parameter defaults are not enough, and we need to write factory methods other than new for creating instances of our class. Suppose that we want to be able to initialize Point objects using either Cartesian or polar coordinates: 

class Point
  #define a initialize method as usual
  def initialize(x,y)
    @x,@y = x,y
  end

  def to_s
    "{#@x,#@y}"
  end
  # but make the facotry method new private
  private_class_method :new

  def self.cartesian(x,y)   # factory method for cartesian coordinates
    new(x,y)
  end

  def self.polar(r,theta)   # factory method for polar coordinates
    new(r*Math.cos(theta),r*Math.sin(theta))
  end
end
#This code still relies on new and initialize, but it makes new private, so that users of the Point class can't call it directly. Instead, they must use one of the custom factory methods. 

# puts Point.new(1,2)  # error
puts Point.cartesian(2,3)
puts Point.polar(5, Math::PI/3)


# 7.4.3 dup, clone, and initialize_copy

# Another way that new objects come into existence is as a result of the dup and clone methods (see Section 3.8.8). These methods allocate a new instance of the class of the object on which they are invoked. They then copy all the instance variables and the taintedness of the receiver object to the newly allocated object. clone takes this copying a step further than dup—it also copies singleton methods of the receiver object and freezes the copy object if the original is frozen. 

# If a class defines a method named initialize_copy, then clone and dup will invoke that method on the copied object after copying the instance variables from the original. (clone calls initialize_copy before freezing the copy object, so that initialize_copy is still allowed to modify it.) The initialize_copy method is passed the original object as an argument and has the opportunity to make any changes it desires to the copied object. It cannot create its own copy object, however; the return value of initialize_copy is ignored. Like initialize, Ruby ensures that initialize_copy is always private. 

# When clone and dup copy instance variables from the original object to the copy, they copy references to the values of those variables; they do not copy the actual values. In other words, these methods perform a shallow copy. And this is one reason that many classes might want to alter the behavior of these methods. Here is code that defines an initialize_copy method to do a deeper copy of internal state: 

class PointN                 # a point in n-space
  def initialize(*coords)   # accept an arbitary # of coordinates
    @coords = coords           # store the coordinates in an array
  end

  def initialize_copy(orig)  # if someone copies this Point object
    @coords = @coords.dup # make a copy of the coordinates array, too
  end

  def to_s
     [self,@coords]
  end
end

print p1  = PointN.new(1,2,3)
print p1.dup, p1.clone, "\n"


# The class shown here stores its internal state in an array. Without an initialize_copy method, if an object were copied using clone or dup, the copied object would refer to the same array of state that the original object did. Mutations performed on the copy would affect the state of the original. As this is not the behavior we want, we must define initialize_copy to create a copy of the array as well. 

#Some classes, such as those that define enumerated types, may want to strictly limit the number of instances that exist. Classes like these need to make their new method private and also probably want to prevent copies from being made. The following code demonstrates one way to do that: 

class Season
  NAMES = %w{ Spring Summer Autumn Winter }  # Array of season names
  INSTANCES = []                             # Array of Season objects
  def initialize(n)  # The state of a season is just its 
    @n = n           # index in the NAMES and INSTANCES arrays
  end
  def to_s           # Return the name of a season 
    super
  end

  # This code creates instances of this class to represent the seasons 
  # and defines constants to refer to those instances.
  # Note that we must do this after initialize is defined.
  NAMES.each_with_index do |name,index|
    instance = new(index)         # Create a new instance
    INSTANCES[index] = instance   # Save it in an array of instances
    const_set name, instance      # Define a constant to refer to it
  end
  # Now that we have created all the instances we'll ever need, we must
  # prevent any other instances from being created
  private_class_method :new,:allocate  # Make the factory methods private
  private :dup, :clone                 # Make copying methods private
end

#Season.new  #  private method `new' called for Season:Class (NoMethodError)
 Season::Spring


# This code involves some metaprogramming techniques that will make more sense after you have read Chapter 8. The main point of the code is the line at the end that makes the dup and clone methods private. 

# Another technique to prevent copying of objects is to use undef to simply remove the clone and dup methods. Yet another approach is to redefine the clone and dup methods so that they raise an exception with an error message that specifically says that copies are not permitted. Such an error message might be helpful to programmers who are using your class. 


#7.4.4 marshal_dump and marshal_load

# A third way that objects are created is when Marshal.load is called to re-create objects previously marshaled (or "serialized") with Marshal.dump. Marshal.dump saves the class of an object and recursively marshals the value of each of its instance variables. This works well—most objects can be saved and restored using these two methods. 

# Some classes need to alter the way marshaling (and unmarshaling) is done. One reason is to provide a more compact representation of an object's state. Another reason is to avoid saving volatile data, such as the contents of a cache that would just need to be cleared when the object was unmarshaled. You can customize the way an object is marshaled by defining a marshal_dump instance method in the class; it should return a different object (such as a string or an array of selected instance variable values) to be marshaled in place of the receiver object. 

# If you define a custom marshal_dump method, you must define a matching marshal_load method, of course. marshal_load will be invoked on a newly allocated (with allocate) but uninitialized instance of the class. It will be passed a reconstituted copy of the object returned by marshal_dump, and it must initialize the state of the receiver object based on the state of the object it is passed. 

## As an example, let's return to the multidimensional Point class we started earlier. If we add the constraint that all coordinates are integers, then we can shave a few bytes off the size of the marshaled object by packing the array of integer coordinates into a string (you may want to use ri to read about Array.pack to help you understand this code): 

class PointN # a point in n-space
  def initialize(*coords)
    @coords = coords
  end
  
  def marshal_dump          # pack coords into a sring and marshal that
    @coords.pack("w*")
  end

  def marshal_load(s)    # unpack coords from unmarshaled string
    @coords = s.unpack("w*")   # and use them to initialize the object
  end
end

print p1 = PointN.new(1,2,3)
print data = Marshal.dump(p1)
print p2 = Marshal.load(data), "\n"


    

=begin

If you are writing a class—such as the Season class shown previously—for which you have disabled the clone and dup methods, you will also need to implement custom marshaling methods because dumping and loading an object is an easy way to create a copy of it. You can prevent marshaling completely by defining marshal_dump and marshal_load methods that raise an exception, but that is rather heavy-handed. A more elegant solution is to customize the unmarshaling so that Marshal.load returns an existing object rather than creating a copy. 

To accomplish this, we must define a different pair of custom marshaling methods because the return value of marshal_load is ignored. _dump is an instance method that must return the state of the object as a string. The matching _load method is a class method that accepts the string returned by _dump and returns an object. _load is allowed to create a new object or return a reference to an existing one. 

To allow marshaling, but prevent copying, of Season objects, we add these methods to the class: 
=end

class Season
  def _dump(limit)    # custom marshaling method, limit is the depth of marshaling
    @n.to_s              # here return index as a string
  end

  def self._load(s)  # custom unmarshaling metod
    INSTANCES[Integer(s)]  #return an existing instance
  end
end

print s = Season::Summer
print data = Marshal.dump(s)
print s2 = Marshal.load(data), "\n"



# 7.4.5. The Singleton Pattern

=begin

A singleton is a class that has only a single instance. Singletons can be used to store global program state within an object-oriented framework and can be useful alternatives to class methods and class variables. 

Singleton Terminology

This section discusses the "Singleton Pattern," a well-known design pattern in object-oriented programming. In Ruby, we have to be careful with the term "singleton" because it is overloaded. A method added to a single object rather than to a class of objects is known as a singleton method (see Section 6.1.4). The implicit class object to which such singleton methods are added is sometimes called a singleton class (though this book uses the term eigenclass instead; see Section 7.7). 

Properly implementing a singleton requires a number of the tricks shown earlier. 
> The new and allocate methods must be made private, 
> dup and clone must be prevented from making copies, and so on. 

Fortunately, the Singleton module in the standard library does this work for us; just require 'singleton' and then include Singleton into your class. This defines a class method named instance, which takes no arguments and returns the single instance of the class. Define an initialize method to perform initialization of the single instance of the class. Note, however, that no arguments will be passed to this method. 

=end

require 'singleton'


class PointStats
  include Singleton

  def initialize              # A normal initialization method
    @n, @totalX, @totalY = 0, 0.0, 0.0
  end
  def record(point)           # Record a new point
    @n += 1
    @totalX += point.x
    @totalY += point.y
  end
  def report                  # Report point statistics
    puts "Number of points created: #@n"
    puts "Average X coordinate: #{@totalX/@n}"
    puts "Average Y coordinate: #{@totalY/@n}"
  end
end

# With a class like this in place, we might write the initialize method for our Point class like this: 

class Point
  def initialize(x,y)
    @x,@y = x,y
    PointStats.instance.record(self)
  end

  public_class_method :new
end

# The Singleton module automatically creates the instance class method for us, and we invoke the regular instance method record on that singleton instance. Similarly, when we want to query the point statistics, we write: 

print Point.new(1,2), Point.new(2,1)
s = PointStats.instance
s.report

#s.dup  # `dup': can't dup instance of singleton PointStats (TypeError)
#s.clone   # 99:in `clone': can't clone instance of singleton PointStats (TypeError)
#PointStats.new  # new  # private method `new' called for #<PointStats:..


data =  Marshal.dump(s)
	

    
