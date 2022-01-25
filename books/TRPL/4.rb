# -*- coding: utf-8 -*-

# Chapter 4. Expressions and Operators
x=2
# An expression is a chunk of Ruby code that the Ruby interpreter can evaluate to produce a value. Here are some sample expressions: 

2                  # A numeric literal
x                  # A local variable reference
Math.sqrt(2)       # A method invocation
x = Math.sqrt(2)   # Assignment
x*x                # Multiplication with the * operator

# As you can see, primary expressions—such as literals, variable references, and method invocations—can be combined into larger expressions with operators, such as the assignment operator and the multiplication operator. 

# Many programming languages distinguish between low-level expressions and higher-level statements, such as conditionals and loops. In these languages, statements control the flow of a program, but they do not have values. They are executed, rather than evaluated. In Ruby, there is no clear distinction between statements and expressions; everything in Ruby, including class and method definitions, can be evaluated as an expression and will return a value. It is still useful, however, to distinguish syntax typically used as expressions from syntax typically used as statements. 

#Ruby expressions that affect flow-of-control are documented in Chapter 5. Ruby expressions that define methods and classes are covered in Chapters Chapter 6 and Chapter 7. 


# This chapter covers the simpler, more traditional sort of expressions. The simplest expressions are literal values, which we already documented in Chapter 3. This chapter explains variable and constant references, method invocations, assignment, and compound expressions created by combining smaller expressions with operators. 
