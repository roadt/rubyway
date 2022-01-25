

# 6.3 Methods and Parentheses

#Ruby allows parentheses to be omitted from most method invocations. In simple cases, this results in clean-looking code. In complex cases, however, it causes syntactic ambiguities and confusing corner cases. We'll consider these in the sections that follow. 

# 6.3.31 optional parenthese

#Parentheses are omitted from method invocations in many common Ruby idioms
puts "hello, world"
puts ("hello, world")

#  next
greeting = "hello"
size = greeting.length


#If you are accustomed to other object-oriented languages, you may think that length is a property, field, or variable of string objects. Ruby is strongly object oriented, however, and its objects are fully encapsulated; the only way to interact with them is by invoking their methods. In this code, greeting.length is a method invocation. The length method expects no arguments and is invoked without parentheses. The following code is equivalent: 

size = greeting.length()

# Including the optional parentheses emphasizes that a method invocation is occurring. Omitting the parentheses in method invocations with no arguments gives the illusion of property access, and is a very common pra

# Parentheses are very commonly omitted when there are zero or one arguments to the invoked method. Although it is less common, the parentheses may be omitted even when there are multiple arguments, as in the following code: 

x = 3  # x is number

x.between? 1,5  # same as x.between?(1,5)

#Parentheses may also be omitted around the parameter list in method definitions, though it is hard to argue that this makes your code clearer or more readable. The following code, for example, defines a method that returns the sum of its arguments: 

def sum x,y
  x + y  
end


# 6.3.2  required parentheses

#Some code is ambiguous if the parentheses are omitted, and here Ruby requires that you include them. The most common case is nested method invocations of the form f g x, y. In Ruby, invocations of that form mean f(g(x,y)). 

puts sum 2,2    # does this mean puts (sum(2,2)) or puts(sum(2), 2)?

#Note that using parentheses around the outer method invocation does not resolve the ambiguity: 

puts(sum 2,2)   # Does this mean puts(sum(2,2)) or puts(sum(2), 2)?

#An expression involving nested function calls is only ambiguous when there is more than one argument. 

def fact n 
  return 1 if n <=1
  n * fact(n-1)
end
puts fact 5

#Sometimes omitting parentheses is a true syntax error rather than a simple warning. The following expressions, for example, are completely ambiguous without parentheses, and Ruby doesn't even attempt to guess what you mean: 

#puts 4, sum 2,2   # error: does the second comma go with the 1st or 2nd method?
#[sum 2,2]    # error; two array elements or one?


#There is another wrinkle that arises from the fact that parentheses are optional. When you do use parentheses in a method invocation, the opening parenthesis must immediately follow the method name, with no intervening space. This is because parentheses do double-duty: they can be used around an argument list in a method invocation, and they can be used for grouping expressions. Consider the following two expressions, which differ only by a single space: 

def square (x)
  x * x
end

square(2+2)*2  # square(4)*2 = 16*2 = 32
square (2+2)*2  # square (4*2) = square(8) = 64

#To reduce the potential for confusion, you should always use parentheses around a method invocation if any of the arguments use parentheses. e.g.
square((2+2)*2)

#We'll end this discussion of parentheses with one final twist. Recall that the following expression is ambiguous and causes a warning: 

puts(sum 2,2)   # Does this mean puts(sum(2,2)) or puts(sum(2), 2)?

#The best way to resolve this ambiguity is to put parentheses around the arguments to the sum method. Another way is to add a space between puts and the opening parenthesis: 

puts (sum 2,2)
#Adding the space converts the method invocation parentheses into expression grouping parentheses. Because these parentheses group a subexpression, the comma can no longer be interpreted as an argument delimiter for the puts invocation. 
