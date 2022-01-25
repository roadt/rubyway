# -*- coding: utf-8 -*-



# create proc

def makeproc(&p)
  p
end

adder = makeproc {|x,y| x+y}
puts sum = adder.call(2,2)

# Proc.new, lambda, proc

# 6.5.1.1 Proc.new


# We've already seen Proc.new used in some of the previous examples in this chapter. This is the normal new method that most classes support, and it's the most obvious way to create a new instance of the Proc class. Proc.new expects no arguments, and returns a Proc object that is a proc (not a lambda). When you invoke Proc.new with an associated block, it returns a proc that represents the block. For example: 
p = Proc.new {|x,y| x+y}

# If Proc.new is invoked without a block from within a method that does have an associated block, then it returns a proc representing the block associated with the containing method. Using Proc.new in this way provides an alternative to using an ampersand-prefixed block argument in a method definition. The following two methods are equivalent, for example: 
def invoke(&b)
  b.call
end

def invoke2
  Proc.new.call
end

invoke { puts 'xx' }
invoke2 {puts 'xx'}



# 6.5.1.2 Kernel.lambda

# Another technique for creating Proc objects is with the lambda method. lambda is a method of the Kernel module, so it behaves like a global function. As its name suggests, the Proc object returned by this method is a lambda rather than a proc. lambda expects no arguments, but there must be a block associated with the invocation: 

is_positive = lambda {|x| x>0}

#Lambda History
#Lambdas and the lambda method are so named in reference to lambda calculus, a branch of mathematical logic that has been applied to functional programming languages. Lisp also uses the term "lambda" to refer to functions that can be manipulated as objects. 

# 6.5.1.3. Kernel.proc

# In Ruby 1.8, the global proc method is a synonym for lambda. Despite its name, it returns a lambda, not a proc. Ruby 1.9 fixes this; in that version of the language, proc is a synonym for Proc.new. 

# Because of this ambiguity, you should never use proc in Ruby 1.8 code. The behavior of your code might change if the interpreter was upgraded to a newer version. If you are using Ruby 1.9 code and are confident that it will never be run with a Ruby 1.8 interpreter, you can safely use proc as a more elegant shorthand for Proc.new. 

# 6.5.1.4. Lambda Literals

# Ruby 1.9 supports an entirely new syntax for defining lambdas as literals. We'll begin with a Ruby 1.8 lambda, created with the lambda method: 

succ = lambda {|x| x+1}

=begin
In Ruby 1.9, we can convert this to a literal as follows: 

Replace the method name lambda with the punctuation ->.

Move the list of arguments outside of and just before the curly braces.

Change the argument list delimiters from || to ().
With these changes, we get a Ruby 1.9 lambda literal: 
=end

succ2 = ->(x){x+1}

#succ now holds a Proc object, which we can use just like any other: 

succ.call(2)
succ2.call(2)

# The introduction of this syntax into Ruby was controversial, and it takes some getting used to. Note that the arrow characters -> are different from those used in hash literals. A lambda literal uses an arrow made with a hyphen, whereas a hash literal uses an arrow made with an equals sign. 

# As with blocks in Ruby 1.9, the argument list of a lambda literal may include the declaration of block-local variables that are guaranteed not to overwrite variables with the same name in the enclosing scope. Simply follow the parameter list with a semicolon and a list of local variables: 

# This lambda takes 2 args and declares 3 local vars
f = ->(x,y;i,j,k){ i,j,k=x,y,x+y; [i,j,k]}

print  f.call(2,3), "\n"


# One benefit of this new lambda syntax over the traditional block-based lambda creation methods is that the Ruby 1.9 syntax allows lambdas to be declared with argument defaults, just as methods can be: 

zoom = ->(x,y,factor=2) { [x*factor, y*factor] }

# As with method declarations, the parentheses in lambda literals are optional, because the parameter list and local variable lists are completely delimited by the ->, ;, and {. We could rewrite the three lambdas above like this: 

succ = ->x {x+1}
#f = ->x,y;i,j,k { i,j,k=x,y,x+y; [i,j,k]}   # doesn't works for
zoom = ->x,y,factor=2{[x*factor, y*factor]}

# Lambda parameters and local variables are optional, of course, and a lambda literal can omit this altogether. The minimal lambda, which takes no arguments and returns nil, is the following: 
fnil = ->{}

# One benefit of this new syntax is its succinctness. It can be helpful when you want to pass a lambda as an argument to a method or to another lambda: 

def compose(f,g)  # compose 2 lambdas
  ->(x) {f.call(g.call(x))}
end
succOfSquare = compose(->x{x+1}, ->x{x*x})
puts succOfSquare.call(4)


# Lambda literals create Proc objects and are not the same thing as blocks. If you want to pass a lambda literal to a method that expects a block, prefix the literal with &, just as you would with any other Proc object. Here is how we might sort an array of numbers into descending order using both a block and a lambda literal: 

print data = [1,3,5,6]
print data.sort {|a,b| b-a}
print data.sort &->(a,b){b-a} # the lambda literal version
puts

# in this case, as you can see, regular block is simpler.

# 6.5.2  Invoking Proc and Lambdas

#Procs and lambdas are objects, not methods, and they cannot be invoked in the same way that methods are. If p refers to a Proc object, you cannot invoke p as a method. But because p is an object, you can invoke a method of p. We've already mentioned that the Proc class defines a method named call. Invoking this method executes the code in the original block. The arguments you pass to the call method become arguments to the block, and the return value of the block becomes the return value of the call method: 

x,y = 3.0, 4.0

f = Proc.new {|x,y| 1.0/(1.0/x+1.0/y)}
puts z = f.call(x,y)

# The Proc class also defines the array access operator to work the same way as call. This means that you can invoke a proc or lambda using a syntax that is like method invocation, where parentheses have been replaced with square brackets. The proc invocation above, for example, could be replaced with this code: 

puts z = f[x,y]

# Ruby 1.9 offers an additional way to invoke a Proc object; as an alternative to square brackets, you can use parentheses prefixed with a period: 

puts z = f.(x,y)


# .() looks like a method invocation missing the method name. This is not an operator that can be defined, but rather is syntactic-sugar that invokes the call method. It can be used with any object that defines a call method and is not limited to Proc objects. 

# 6.5.3. The Arity of a Proc

# The arity of a proc or lambda is the number of arguments it expects. (The word is derived from the "ary" suffix of unary, binary, ternary, etc.) Proc objects have an arity method that returns the number of arguments they expect. For example: 

lambda{||}.arity        # => 0. No arguments expected
lambda{|x| x}.arity     # => 1. One argument expected
lambda{|x,y| x+y}.arity # => 2. Two arguments expected


# The notion of arity gets confusing when a Proc accepts an arbitrary number of arguments in an *-prefixed final argument. When a Proc allows optional arguments, the arity method returns a negative number of the form -n-1. A return value of this form indicates that the Proc requires n arguments, but it may optionally take additional arguments as well. -n-1 is known as the one's-complement of n, and you can invert it with the ~ operator. So if arity returns a negative number m, then ~m (or -m-1) gives you the number of required arguments: 
#Code View:

lambda {|*args|}.arity        # => -1.  ~-1 = -(-1)-1 = 0 arguments required
lambda {|first, *rest|}.arity # => -2.  ~-2 = -(-2)-1 = 1 argument required

# There is one final wrinkle to the arity method. In Ruby 1.8, a Proc declared without any argument clause at all (that is, without any || characters) may be invoked with any number of arguments (and these arguments are ignored). The arity method returns –1 to indicate that there are no required arguments. This has changed in Ruby 1.9: a Proc declared like this has an arity of 0. If it is a lambda, then it is an error to invoke it with any arguments: 

puts lambda {}.arity # -1 in ruby 1.8; 0 in ruby 1.9


# 6.5.4 Proc Equality

# The Proc class defines an == method to determine whether two Proc objects are equal. It is important to understand, however, that merely having the same source code is not enough to make two procs or lambdas equal to each other: 

lambda {|x| x*x } == lambda {|x| x*x }  # => false


# The == method only returns true if one Proc is a clone or duplicate of the other: 

p = lambda {|x| x*x }
q = p.dup
p == q                      # => true: the two procs are equal
p.object_id == q.object_id  # => false: they are not the same object

# 6.5.5. How Lambdas Differ from Procs
