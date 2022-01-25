# -*- coding: utf-8 -*-


# 4.3. Constant References

=begin

A constant in Ruby is like a variable, except that its value is supposed to remain constant for the duration of a program. The Ruby interpreter does not actually enforce the constancy of constants, but it does issue a warning if a program changes the value of a constant. Lexically, the names of constants look like the names of local variables, except that they begin with a capital letter. By convention, most constants are written in all uppercase with underscores to separate words, LIKE_THIS. Ruby class and module names are also constants, but they are conventionally written using initial capital letters and camel case, LikeThis. 

Although constants look like local variables with capital letters, they have the visibility of global variables: they can be used anywhere in a Ruby program without regard to scope. Unlike global variables, however, constants can be defined by classes and modules and can therefore have qualified names. 

A constant reference is an expression that evaluates to the value of the named constant. The simplest constant references are primary expressions—they consist simply of the name of the constant: 

=end

CM_PER_INCH = 2.54  # Define a constant.
CM_PER_INCH         # Refer to the constant. Evaluates to 2.54.

#In addition to simple references like this one, constant references can also be compound expressions. In this case, :: is used to separate the name of the constant from the class or module in which it is defined. The lefthand side of the :: may be an arbitrary expression that evaluates to a class or module object. (Usually, however, this expression is a simple constant reference that just names the class or module.) The righthand side of the :: is the name of a constant defined by the class or module. For example: 

#Conversions::CM_PER_INCH # Constant defined in the Conversions module
#modules[0]::NAME         # Constant defined by an element of an array

# Modules may be nested, which means that constants may be defined in nested namespaces like this: 
# Conversions::Area::HECTARES_PER_ACRE


#The lefthand side of the :: may be omitted, in which case the constant is looked up in the global scope: 

# ::ARGV      # The global constant ARGV

# Note that there is not actually a "global scope" for constants. Like global functions, global constants are defined (and looked up) within the Object class. The expression ::ARGV, therefore, is simply shorthand for Object::ARGV. 

# When a constant reference expression is qualified with a ::, Ruby knows exactly where to look up the specified constant. 
# When there is no qualifying ::, however, the Ruby interpreter must search for an appropriate definition of the constant. It searches the lexically enclosing scope as well as the inheritance hierarchy of the enclosing class or module. Complete details are in Section 7.9. 


# When Ruby evaluates a constant reference expression, it returns the value of the constant, or it raises a NameError exception if no constant by that name could be found. Note that constants do not exist until a value is actually assigned to them. This is unlike variables that can come into existence when the interpreter sees, but does not execute, an assignment. 

# The Ruby interpreter predefines some constants when it starts up. See Chapter 10 for a list. 

