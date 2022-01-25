# -*- coding: utf-8 -*-


# 4.1. Literals and Keyword Literals

# literals are values such as 1.0, 'hello world', and [] that are embedded directly into your program text. We introduced them in Chapter 2 and documented them in detail in Chapter 3. 

print [1.0, 'hello, world', []]
puts

# It is worth noting that many literals, such as numbers, are primary expressions—the simplest possible expressions not composed of simpler expressions. Other literals, such as array and hash literals and double-quoted strings that use interpolation, include subexpressions and are therefore not primary expressions. 

# Certain Ruby keywords are primary expressions and can be considered keyword literals or specialized forms of variable reference: 

=begin

nil 
Evaluates to the nil value, of class NilClass.

true 
Evaluates to the singleton instance of class TrueClass, an object that represents the Boolean value true.

false 
Evaluates to the singleton instance of class FalseClass, an object that represents the Boolean value false.

self 
Evaluates to the current object. (See Chapter 7 for more about self.)

__FILE__ 
Evaluates to a string that names the file that the Ruby interpreter is executing. This can be useful in error messages.

__LINE__ 
Evaluates to an integer that specifies the line number within __FILE__ of the current line of code.

__ENCODING__ 
Evaluates to an Encoding object that specifies the encoding of the current file. (Ruby 1.9 only.)

=end


print [nil, true,false,  self, __FILE__, __LINE__, __ENCODING__ ]
puts
