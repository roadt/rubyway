

# Defining Simple Methods


 
#Methods are defined with the def keyword. This is followed by the method name and an optional list of parameter names in parentheses.
def factorial(n)
  if n < 1
    raise "argument must be > 0"
  elsif n == 1
    1
  else
    n*factorial(n-1)
  end
end



#6.1.1  method return value

#Methods may terminate normally or abnormally. Abnormal termination occurs when the method raises an exception. If a method terminates normally, then the value of the method invocation expression is the value of the last expression evaluated within the method body.

#The return keyword is used to force a return prior to the end of the method.  If an expression follows the return keyword, then the value of that expression is returned. If no expression follows, then the return value is nil.

def facotrial2 (n)
  raise "bad argument" if n < 1
  return 1 if n==1
  n*factorial(n-1)
end

# We could also use return on the last line of this method body to emphasize that this expression is the method's return value. In common practice, however, return is omitted where it is not required. 
#  Ruby methods may return more than one value. To do this, use an explicit return statement, and separate the values to be returned with commas: 

def polar (x,y)
  return Math.hypot(y,x), Math.atan2(y,x)
end

# When there is more than one return value, the values are collected into an array, and the array becomes the single return value of the method. Instead of using the return statement with multiple values, we can simply create an array of values ourselves: 
def cartesian(magnitude, angle)
  [magnitude*Math.cos(angle), magnitude*Math.sin(angle)]
end

distance, theta = polar(5,4)
x,y = cartesian(distance, theta)


# 6.1.2 methods and exception handling
#A def statement that defines a method may include exception-handling code in the form of rescue, else, and ensure clauses, just as a begin statement can. These exception-handling clauses go after the end of the method body but before the end of the def statement. In short methods, it can be particularly tidy to associate your rescue clauses with the def statement. This also means you don't have to use a begin statement and the extra level of indentation that comes with it. See Section 5.6.6 for further details. 

#6.1.3 Invoking a method on a object.
# Methods are always invoked on an object. (This object is sometimes called the receiver in a reference to an object-oriented paradigm in which methods are called "messages" and are "sent to" receiver objects.) Within the body of a method, the keyword self refers to the object on which the method was invoked. If we don't specify an object when invoking a method, then the method is implicitly invoked on self. 

puts first = "abcdefg".index("e")


# 6.1.4 Defining singleton method

# The methods we've defined so far are all global methods. If we place a def statement like the ones shown earlier inside a class statement, then the methods that are defined are instance methods of the class; these methods are defined on all objects that are instances of the class. (Classes and instance methods are explained in Chapter 7.) 

# It is also possible, however, to use the def statement to define a method on a single specified object. Simply follow the def keyword with an expression that evaluates to an object. This expression should be followed by a period and the name of the method to be defined. The resulting method is known as a singleton method because it is available only on a single object: 

o = "message" # a string is an object
def o.printme  # define a singleton method for this object
  puts self
 end
o.printme  # invoke the singleton
  end

#Class methods (covered in Chapter 7) such as Math.sin and File.delete are actually singleton methods. Math is a constant that refers to a Module object, and File is a constant that refers to a Class object. These two objects have singleton methods named sin and delete, respectively. 

# Ruby implementations typically treat Fixnum and Symbol values as immediate values rather than as true object references. (See Section 3.8.1.1.) For this reason, singleton methods may not be defined on Fixnum and Symbol objects. For consistency, singletons are also prohibited on other Numeric objects. 

# 6.1.5 undefining methods

# Methods are defined with the def statement and may be undefined with the undef statement: 

def sum(x,y); x+y; end
puts sum(1,2)
undef sum

#In this code, the def statement defines a global method, and undef undefines it. undef also works within classes (which are the subject of Chapter 7) to undefine the instance methods of the class. 

# Interestingly, undef can be used to undefine inherited methods, without affecting the definition of the method in the class from which it is inherited. Suppose class A defines a method m, and class B is a subclass of A and therefore inherits m. (Subclasses and inheritance are also explained in Chapter 7.) If you don't want to allow instances of class B to be able to invoke m, you can use undef m within the body of the subclass. 

# undef is not a commonly used statement. In practice, it is much more common to redefine a method with a new def statement than it is to undefine or delete the method. 


#Note that the undef statement must be followed by a single identifier that specifies the method name. It cannot be used to undefine a singleton method in the way that def can be used to define such a method. 

#Within a class or module, you can also use undef_method (a private method of Module) to undefine methods. Pass a symbol representing the name of the method to be undefined
