
##
#  ruby has three kind of variables.  contant and 2 pseudo-variables.
#  $ - global variable
#  @ instance variable
#  [a-z] or _ local variable
#  [A-Z] constant
#
#exception : 
#   self - current executing object. if no values to self or nil.   main is assigned as default.
#   nil - meaningless, be assigned to unintialzied vairable.
#


puts self
puts nil




=begin
Ruby has three kinds of variables, one kind of constant and exactly two pseudo-variables. The variables and the constants have no type. While untyped variables have some drawbacks, they have many more advantages and fit well with ruby's quick and easy philosophy.

Variables must be declared in most languages in order to specify their type, modifiability (i.e., whether they are constants), and scope; since type is not an issue, and the rest is evident from the variable name as you are about to see, we do not need variable declarations in ruby.

The first character of an identifier categorizes it at a glance:

$	 global variable
@	 instance variable
[a-z] or _	 local variable
[A-Z]	 constant
The only exceptions to the above are ruby's pseudo-variables: self, which always refers to the currently executing object, and nil, which is the meaningless value assigned to uninitialized variables. Both are named as if they are local variables, but self is a global variable maintained by the interpreter, and nil is really a constant. As these are the only two exceptions, they don't confuse things too much.

You may not assign values to self or nil. main, as a value of self, refers to the top-level object:
=end
