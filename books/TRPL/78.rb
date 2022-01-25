# -*- coding: utf-8 -*-

#7.8. Method Lookup

=begin

When Ruby evaluates a method invocation expression, it must first figure out which method is to be invoked. The process for doing this is called method lookup or method name resolution. For the method invocation expression o.m, Ruby performs name resolution with the following steps: 
1. 
First, it checks the eigenclass of o for singleton methods named m.
2. 
If no method m is found in the eigenclass, Ruby searches the class of o for an instance method named m.
3. 
If no method m is found in the class, Ruby searches the instance methods of any modules included by the class of o. If that class includes more than one module, then they are searched in the reverse of the order in which they were included. That is, the most recently included module is searched first.
4. 
If no instance method m is found in the class of o or in its modules, then the search moves up the inheritance hierarchy to the superclass. Steps 2 and 3 are repeated for each class in the inheritance hierarchy until each ancestor class and its included modules have been searched.
5. 
If no method named m is found after completing the search, then a method named method_missing is invoked instead. In order to find an appropriate definition of this method, the name resolution algorithm starts over at step 1. The Kernel module provides a default implementation of method_missing, so this second pass of name resolution is guaranteed to succeed. The method_missing method is covered in more detail in Section 8.4.5.


Let's consider a concrete example of this algorithm. Suppose we have the following code: 
message = "hello"
message.world

We want to invoke a method named world on the String instance "hello". Name resolution proceeds as follows: 

1. 
Check the eigenclass for singleton methods. There aren't any in this case.
2. 
Check the String class. There is no instance method named world.
3. 
Check the Comparable and Enumerable modules of the String class for an instance method named world. Neither module defines such a method.
4. 
Check the superclass of String, which is Object. The Object class does not define a method named world, either.
5. 
Check the Kernel module included by Object. The world method is not found here either, so we now switch to looking for a method named method_missing.
6. 
Look for method_missing in each of the spots above (the eigenclass of the String object, the String class, the Comparable and Enumerable modules, the Object class, and the Kernel module). The first definition of method_missing we find is in the Kernel module, so this is the method we invoke. What it does is raise an exception:

NoMethodError: undefined method `world' for "hello":String

This may seem like it requires Ruby to perform an exhaustive search every time it invokes a method. In typical implementations, however, successful method lookups will be cached so that subsequent lookups of the same name (with no intervening method definitions) will be very quick. 


=end


# 7.8.1. Class Method Lookup

# The name resolution algorithm for class methods is exactly the same as it is for instance methods, but there is a twist. Let's start with a simple case, without the twist. Here is a class C that defines no class methods of its own: 

class C
end

=begin

Remember that after we define a class like this, the constant C refers to an object that is an instance of Class. Any class methods we define are simply singleton methods of the object C. 

Once we have defined a class C, we are likely to write a method invocation expression involving the class method new: 

=end

c = C.new

=begin

To resolve the method new, Ruby first looks for singleton methods in the eigenclass of the object C. Our class does not have any class methods, so nothing is found there. After searching the eigenclass, the name resolution algorithm searches the class object of C. The class of C is Class, so Ruby next looks for methods in Class, and it finds an instance method named new there. 

You read that right. The method name resolution algorithm for the class method C.new ends up locating the instance method Class.new. The distinction between instance methods and class methods is a useful one to draw in the object-oriented programming paradigm, but the truth is that in Ruby—where classes are represented by objects—the distinction is somewhat artificial. Every method invocation, whether instance method or class method, has a receiver object and a method name. The name resolution algorithm finds the appropriate method definition for that object. Our object C is an instance of class Class, so we can of course invoke the instance methods of Class through C. Furthermore, Class inherits the instance methods of Module, Object, and Kernel, so those inherited methods are also available as methods of C. The only reason we call these "class methods" is that our object C happens to be a class. 

Our class method C.new is found as an instance method of Class. If it had not been found there, however, the name resolution algorithm would have continued just as it would have for an instance method. After searching Class unsuccessfully, we would have looked at modules (Class doesn't include any) and then at the superclass Module. Next, we would search the modules of Module (there aren't any), and finally the superclass of Module, Object, and its module Kernel. 

The twist mentioned at the beginning of this section has to do with the fact that class methods are inherited just like instance methods are. Let's define a class method Integer.parse to use as an example: 


def Integer.parse(text)
  text.to_i
end

Because Fixnum is a subclass of Integer, we can invoke this method with an expression like this: 
n = Fixnum.parse("1")

From the description of the method name resolution algorithm that we've seen previously, we know that Ruby would first search the eigenclass of Fixnum for singleton methods. Next, it would search for instance methods of Class, Module, Object, and Kernel. So where does it find the parse method? A class method of Integer is just a singleton method of the Integer object, which means that it is defined by the eigenclass of Integer. So how does this eigenclass of Integer get involved in the name resolution algorithm? 

Class objects are special: they have superclasses. The eigenclasses of class objects are also special: they have superclasses, too. The eigenclass of an ordinary object stands alone and has no superclass. Let's use the names Fixnum' and Integer' to refer to the eigenclasses of Fixnum and Integer. The superclass of Fixnum' is Integer'. 

With that twist in mind, we can now more fully explain the method name resolution algorithm and say that when Ruby searches for singleton methods in the eigenclass of an object, it also searches the superclass (and all ancestors) of the eigenclass as well. So when looking for a class method of Fixnum, Ruby first checks the singleton methods of Fixnum, Integer, Numeric, and Object, and then checks the instance methods of Class, Module, Object, and Kernel. 

=end




## Caution: TestField

class A
end

a = A.new
print [a.singleton_class,a.class, A.singleton_class, A.class, a.singleton_class.ancestors, A.ancestors], "\n"


class Class
  def f
    puts 'Class.f'
  end
end
#a.f  # can't find


class Object
  def f
    puts "Object.f"
  end
end
a.f  # ok

class A
  def f 
    puts 'A.f'
  end
end
a.f


