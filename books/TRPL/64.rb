# -*- coding: utf-8 -*-


# 6.4 Method Arguments

=begin
Simple method declarations include a comma-separated list of argument names (in optional parentheses) after the method name. But there is much more to Ruby's method arguments. The subsections that follow explain: 

How to declare an argument that has a default value, so that the argument can be omitted when the method is invoked

How to declare a method that accepts any number of arguments

How to simulate named method arguments with special syntax for passing a hash to a method

How to declare a method so that the block associated with an invocation of the method is treated as a method argument
=end

# 6.4.1  Paremeter Defaults

def prefix (s,len=1)
  s[0,len]
end

prefix('ruby', 3)
prefix('ruby')

#Argument defaults need not be constants: they may be arbitrary expressions, and can be referred to instance variables and to previous parameters in the parameter list. For example: 

# Return the last character of s or the substring from index to the end
def suffix(s, index=s.size-1)
  s[index, s.size-index]
end


#Parameter defaults are evaluated when a method is invoked rather than when it is parsed. In the following method, the default value [] produces a new empty array on each invocation, rather than reusing a single array created when the method is defined: 

def append(x, a=[])
  a << x
end
puts append('a')


#In Ruby 1.8, method parameters with default values must appear after all ordinary parameters in the parameter list. Ruby 1.9 relaxes this restriction and allows ordinary parameters to appear after parameters with defaults. It still requires all parameters with defaults to be adjacent in the parameter list—you can't declare two parameters with default values with an ordinary parameter between them, for example. When a method has more than one parameter with a default value, and you invoke the method with an argument for some, but not all, of these parameters, they are filled in from left to right.

def f1(x='a',y='b',z,j)
  [x,y,z,j]
end
print f1(1,2)
print f1(1,2,3)
print f1(1,2,3,4)

# 6.4.2 Variable-length argumetn lists and arrays

#Sometimes we want to write methods that can accept an arbitrary number of arguments. To do this, we put an * before one of the method's parameters. Within the body of the method, this parameter will refer to an array that contains the zero or more arguments passed at that position.

## Return the largest of the one or more arguments passed
def max(first, *rest)
  max = first
  rest.each {|x| max=x if x > max}
  max
end
print max(1)
print max(1,2)
print max(1,2,3)


#6.4.2.1 Passing arrays to methods
#We've seen how * can be used in a method declaration to cause multiple arguments to be gathered or coalesced into a single array. It can also be used in a method invocation to scatter, expand, or explode the elements of an array (or range or enumerator) so that each element becomes a separate method argument. The * is sometimes called the splat operator, although it is not a true operator. We've seen it used before in the discussion of parallel assignment in Section 4.5.5. 


#Suppose we wanted to find the maximum value in an array (and that we didn't know that Ruby arrays have a built-in max method!). We could pass the elements of the array to the max method (defined earlier) like this: 

data = [3,2,1]
m = max(*data) #frist = 3 , rest= [2,1]=>3

#Consider what happens without the *: 
max=max(data)  #first = [3,2,1], rest=[] => [3,2,1]

#The * can also be used with methods that return arrays to expand those arrays for use in another method invocation. Consider the polar and cartesian methods defined earlier in this chapter: 

def cartesian(x,y)
  [x,y]
end

def polar (x,y)
  [x,y]
end
x,y = 5,4
puts x,y =  cartesian(*polar(x,y))


#In Ruby 1.9, enumerators are splattable objects. To find the largest letter in a string, for example, we could write: 

puts max(*"hello,world".each_char) # => 'w'


=begin
6.4.3. Mapping Arguments to Parameters
When a method definition includes parameters with default values or a parameter prefixed with an *, the assignment of argument values to parameters during method invocation gets a little bit tricky. 

In Ruby 1.8, the position of the special parameters is restricted so that argument values are assigned to parameters from left to right. The first arguments are assigned to the ordinary parameters. If there are any remaining arguments, they are assigned to the parameters that have defaults. And if there are still more arguments, they are assigned to the array argument. 

Ruby 1.9 has to be more clever about the way it maps arguments to parameters because the order of the parameters is no longer constrained. Suppose we have a method that is declared with o ordinary parameters, d parameters with default values, and one array parameter prefixed with *. Now assume that we invoke this method with a arguments. 

If a is less than o, an ArgumentError is raised; we have not supplied the minimum required number of arguments. 

If a is greater than or equal to o and less than or equal to o+d, then the leftmost a–o parameters with defaults will have arguments assigned to them. The remaining (to the right) o+d–a parameters with defaults will not have arguments assigned to them, and will just use their default values. 

If a is greater than o+d, then the array parameter whose name is prefixed with an * will have a–o–d arguments stored in it; otherwise, it will be empty. 
Once these calculations are performed, the arguments are mapped to parameters from left to right, assigning the appropriate number of arguments to each parameter. 
=end


# 6.4.4  Hashes for Named Arguments

# When a method requires more than two or three arguments, it can be difficult for the programmer invoking the method to remember the proper order for those arguments. Some languages allow you to write method invocations that explicitly specify a parameter name for each argument that is passed. Ruby does not support this method invocation syntax, but it can be approximated if you write a method that expects a hash as its argument or as one of its arguments: 

def sequence(args)
  n = args[:n]||0
  m = args[:m]||1
  c = args[:c]||0

  a = []
  n.times{|i| a << m*i+c}
  a
end
print sequence({:n=>3, :m=>5})


#In order to better support this style of programming, Ruby allows you to omit the curly braces around the hash literal if it is the last argument to the method (or if the only argument that follows it is a block argument, prefixed with &). A hash without braces is sometimes called a bare hash, and when we use one it looks like we are passing separate named arguments, which we can reorder however we like: 

print sequence(:m=>3, :n=>5)


#As with other ruby methods, we can omit the parentheses, too: 
print sequence :m=>3, :n=>5

# ruby 1.9 hash syntax
print sequence c:1, m:3, n:5


#If you omit the parentheses, then you must omit the curly braces. If curly braces follow the method name outside of parentheses, Ruby thinks you're passing a block to the method: 

#sequence {:m=>3, :n=>5}       # Syntax error!




# 6.4.5 block arguments

#Recall from Section 5.3 that a block is a chunk of Ruby code associated with a method invocation, and that an iterator is a method that expects a block. Any method invocation may be followed by a block, and any method that has a block associated with it may invoke the code in that block with the yield statement. To refresh your memory, the following code is a block-oriented variant on the sequence method developed earlier in the chapter: 

def sequence2(n,m,c)
  i = 0
  while (i<n)
    yield i*m+c
    i+=1
  end
end

sequence2(5,2,2) {|x| puts x}

#One of the features of blocks is their anonymity. They are not passed to the method in a traditional sense, they have no name, and they are invoked with a keyword rather than with a method. If you prefer more explicit control over a block (so that you can pass it on to some other method, for example), add a final argument to your method, and prefix the argument name with an ampersand.[*] If you do this, then that argument will refer to the block—if any—that is passed to the method. The value of the argument will be a Proc object, and instead of using yield, you invoke the call method of the Proc:

#[*] We use the term "block argument" instead of "block parameter" for method parameters prefixed with &. This is because the phrase "block parameter" refers to the parameter list (such as |x|) of the block itself.

def sequence3(n,m,c,&b)
  i = 0
  while (i<n)
    b.call(i*m+c)
    i+=1
  end
end

sequence3(5,2,2) {|x| puts x}

#Notice that using the ampersand in this way changes only the method definition. The method invocation remains the same. We end up with the block argument being declared inside the parentheses of the method definition, but the block itself is still specified outside the parentheses of the method invocation. 


#   
# Passing Proc Objects Explicitly
#

#If you create your own Proc object (we'll see how to do this later in the chapter) and want to pass it explicitly to a method, you can do this as you would pass any other value—a Proc is an object like any other. In this case, you should not use an ampersand in the method definition: 

# This version expects an explicitly-created Proc object, not a block
def sequence4(n, m, c, b)  # No ampersand used for argument b
  i = 0
  while(i < n)
    b.call(i*m + c)        # Proc is called explicitly
    i += 1
  end
end

p = Proc.new{|x| print '-',x }
sequence4(5,2,2,p)


#Twice before in this chapter, we've said that a special kind of parameter must be the last one in the parameter list. Block arguments prefixed with ampersands must really be the last one. Because blocks are passed unusually in method invocations, named block arguments are different and do not interfere with array or hash parameters in which the brackets and braces have been omitted. The following two methods are legal, for example: 

def sequence5(args, &b) # Pass arguments as a hash and follow with a block
  n, m, c = args[:n], args[:m], args[:c]
  i = 0
  while(i < n)
    b.call(i*m + c)
    i += 1
  end
end
# Expects one or more arguments, followed by a block
def max(first, *rest, &block) 
  max = first
  rest.each {|x| max = x if x > max }
  block.call(max)
  max
end

#These methods work fine, but notice that you can avoid the complexity of these cases by simply leaving your blocks anonymous and calling them with yield. 

#It is also worth noting that the yield statement still works in a method defined with an & parameter. Even if the block has been converted to a Proc object and passed as an argument, it can still be invoked as an anonymous block, as if the block argument was not there. 

def sequence3(n,m,c,&b)
  i = 0
  while (i<n)
    yield i*m+c
    i+=1
  end
end

sequence3(5,3,3) {|x| print ':',x}


# 6.4.5.1 Using & in method invocation

#We saw earlier that you can use * in a method definition to specify that multiple arguments should be packed into an array, and that you can use * in a method invocation to specify that an array should be unpacked so that its elements become separate arguments. & can also be used in definitions and invocations. We've just seen that & in a method definition allows an ordinary block associated with a method invocation to be used as a named Proc object inside the method. When & is used before a Proc object in a method invocation, it treats the Proc as if it was an ordinary block following the invocation. 

#Consider the following code which sums the contents of two arrays: 
a,b = [1,2,3], [4,5]   #start with some data
puts sum = a.inject(0) { |total, x| total +x }
puts sum = b.inject(sum) {|total,x| total+x}

#We described the inject iterator earlier in Section 5.3.2. If you don't remember, you can look up its documentation with ri Enumerable.inject. The important thing to notice about this example is that the two blocks are identical. Rather than having the Ruby interpreter parse the same block twice, we can create a Proc to represent the block, and use the single Proc object twice: 

summation = Proc.new {|total,x| total + x}
sum = a.inject(0, &summation)
sum = b.inject(sum, &summation)

#If you use & in a method invocation, it must appear before the last argument in the invocation. Blocks can be associated with any method call, even when the method is not expecting a block, and never uses yield. In the same way, any method invocation may have an & argument as its last argument. 

=begin

In a method invocation an & typically appears before a Proc object. But it is actually allowed before any object with a to_proc method. The Method class (covered later in this chapter) has such a method, so Method objects can be passed to iterators just as Proc objects can. 
In Ruby 1.9, the Symbol class defines a to_proc method, allowing symbols to be prefixed with & and passed to iterators. When a symbol is passed like this, it is assumed to be the name of a method. The Proc object returned by the to_proc method invokes the named method of its first argument, passing any remaining arguments to that named method. The canonical case is this: given an array of strings, create a new array of those strings, converted to uppercase. Symbol.to_proc allows us to accomplish this elegantly as follows: 

=end

words = ['and', 'but', 'car']
puts uppercase =  words.map(&:upcase)
puts upper = words.map {|w| w.upcase}
