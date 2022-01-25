
=begin
What is a method? In OO programming, we don't think of operating on data directly from outside an object; rather, objects have some understanding of how to operate on themselves (when asked nicely to do so). You might say we pass messages to an object, and those messages will generally elicit some kind of an action or meaningful reply. This ought to happen without our necessarily knowing or caring how the object really works inside. The tasks we are allowed to ask an object to perform (or equivalently, the messages it understands) are that object's methods.
=end

#In ruby, we invoke a method of an object with dot notation (just as in C++ or Java). The object being talked to is named to the left of the dot.
puts "abdef".length
puts foo = "abc"

puts foo.length

puts foo = ["abcde", "fghij"]
puts foo.length


puts foo[0].length
puts foo[0].length + foo[1].length

puts foo = 5
#puts foo.length
#: undefined method `length' for 5:Fixnum (NoMethodError)



=begin
So it is necessary to know what methods are acceptable to an object, though we need not know how the methods are processed.

If arguments are given to a method, they are generally surrounded by parentheses,

object.method(arg1, arg2)
but they can be omitted if doing so does not cause ambiguity.

object.method arg1, arg2


There is a special variable self in ruby; it refers to whatever object calls a method. This happens so often that for convenience the "self." may be omitted from method calls from an object to itself:

self.method_name(args...)

is the same as

method_name(args...)

What we would think of traditionally as a function call is just this abbreviated way of writing method invocations by self. This makes ruby what is called a pure object oriented language. Still, functional methods behave quite similarly to the functions in other programming languages for the benefit of those who do not grok how function calls are really object methods in ruby. We can speak of functions as if they were not really object methods if we want to.
=end
