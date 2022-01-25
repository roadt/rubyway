# -*- coding: utf-8 -*-

# 4.2. Variable References

# A variable is simply a name for a value. Variables are created and values assigned to them by assignment expressions, which are covered later in this chapter. When the name of a variable appears in a program anywhere other than the lefthand side of an assignment, it is a variable reference expression and evaluates to the value of the variable: 

one = 1.0     # This is an assignment expression
one           # This variable reference expression evaluates to 1.0

# As explained in Chapter 2, there are four kinds of variables in Ruby, and lexical rules govern their names. Variables that begin with $ are global variables, visible throughout a Ruby program. Variables that begin with @ and @@ are instance variables and class variables, used in object-oriented programming and explained in Chapter 7. And variables whose names begin with an underscore or a lowercase letter are local variables, defined only within the current method or block. (See Section 5.4.3 for more about the scope of local variables.) 

# Variables always have simple, unqualified names. If a . or :: appears in an expression, then that expression is either a reference to a constant or a method invocation. For example, Math::PI is a reference to a constant, and the expression item.price is an invocation of the method named price on the value held by the variable item. 

# The Ruby interpreter predefines a number of global variables when it starts up. See Chapter 10 for a list of these variables. 


# 4.2.1. Uninitialized Variables

# In general, you should always assign a value to, or initialize, your variables before using them in expressions. In some circumstances, however, Ruby will allow you to use variables that have not yet been initialized. The rules are different for different kinds of variables: 

=begin

Class variables 
Class variables must always have a value assigned to them before they are used. Ruby raises a NameError if you refer to a class variable to which no value has been assigned. 

Instance variables 
If you refer to an uninitialized instance variable, Ruby returns nil. It is considered bad programming to rely on this behavior, however. Ruby will issue a warning about the uninitialized variable if you run it with the -w option. 

Global variables 
Uninitialized global variables are like uninitialized instance variables: they evaluate to nil, but cause a warning when Ruby is run with the -w flag. 

 
Local variables 
This case is more complicated than the others because local variables don't have a punctuation character as a prefix. This means that local variable references look just like method invocation expressions. If the Ruby interpreter has seen an assignment to a local variable, it knows it is a variable and not a method, and it can return the value of the variable. If there has been no assignment, then Ruby treats the expression as a method invocation. If no method by that name exists, Ruby raises a NameError. 


In general, therefore, attempting to use a local variable before it has been initialized results in an error. There is one quirk—a variable comes into existence when the Ruby interpreter sees an assignment expression for that variable. This is the case even if that assignment is not actually executed. A variable that exists but has not been assigned a value is given the default value nil. 

For example: 
=end

a = 0.0 if false    # This assignment is never executed
print a             # Prints nil: the variable exists but is not assigned
#print b             # NameError: no variable or method named b exists
