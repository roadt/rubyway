# -*- coding: utf-8 -*-

# 7.7. Singleton Methods and the Eigenclass

# We learned in Chapter 6 that it is possible to define singleton methods—methods that are defined for only a single object rather than a class of objects. To define a singleton method sum on an object Point, we'd write: 

class Point
end

def Point.sum
  # method boy goes here
end


# As noted earlier in this chapter, the class methods of a class are nothing more than singleton methods on the Class instance that represents that class. 

# The singleton methods of an object are not defined by the class of that object. But they are methods and they must be associated with a class of some sort. The singleton methods of an object are instance methods of the anonymous eigenclass associated with that object. "Eigen" is a German word meaning (roughly) "self," "own," "particular to," or "characteristic of." The eigenclass is also called the singleton class or (less commonly) the metaclass. The term "eigenclass" is not uniformly accepted within the Ruby community, but it is the term we'll use in this book. 

#  Ruby defines a syntax for opening the eigenclass of an object and adding methods to it. This provides an alternative to defining singleton methods one by one; we can instead define any number of instance methods of the eigenclass. To open the eigenclass of the object o, use class << o. For example, we can define class methods of Point like this: 

class << Point
  def class_metod1   # this  is an instance method ofthe eigenclass
  end                          # it's also a class method of Point.           

  def class_method2  
  end
end

# If you open the eigenclass of a class object within the definition of a class itself, then you can use self instead of repeating the name of the class. To repeat an example from earlier in this chapter: 

class Point
  #instance methods go here

  class << self
    # class methods go here as instance methods of the eigenclass
    
  end
end

=begin
 Be careful with your syntax. Note that there is considerable difference between the following three lines: 

Be careful with your syntax. Note that there is considerable difference between the following three lines: 
class Point            # Create or open the class Point
class Point3D < Point  # Create a subclass of Point
class << Point         # Open the eigenclass of the object Point

In general, it is clearer to define class methods as individual singleton methods without explicitly opening the eigenclass. 

=end

# When you open the eigenclass of an object, self refers to the eigenclass object. The idiom for obtaining the eigenclass of an object o is therefore: 

o = [1,2]
puts eigenclass = class <<o
 self
end

# We can formalize this into a method of Object, so that we can ask for the eigenclass of any object: 

class Object
  def eigenclass
    class << self; self; end
  end
end

# Unless you are doing sophisticated metaprogramming with Ruby, you are unlikely to really need an eigenclass utility function like the one shown here. It is worth understanding eigenclasses, however, because you'll occasionally see them used in existing code, and because they're an important part of Ruby's method name resolution algorithm, which we describe next. 

