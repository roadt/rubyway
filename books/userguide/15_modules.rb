
=begin
Modules in ruby are similar to classes, except:

A module can have no instances.
A module can have no subclasses.
A module is defined by module ... end.
Actually... the Module class of module is the superclass of the Class class of class. Got that? No? Let's move on.

There are two typical uses of modules. One is to collect related methods and constants in a central location. The Math module in ruby's standard library plays such a role:
=end

puts Math.sqrt(2)
puts Math::PI

=begin
The :: operator tells the ruby interpreter which module it should consult for the value of a constant (conceivably, some module besides Math might mean something else by PI). If we want to refer to the methods or constants of a module directly without using ::, we can include that module:
=end

puts include Math
puts sqrt(2)
puts PI

=begin
Another use of modules is called mixin. Some OO programming languages, including C++, allow multiple inheritance, that is, inheritance from more than one superclass. A real-world example of multiple inheritance is an alarm clock; you can think of alarm clocks as belonging to the class of clocks and also the class of things with buzzers.

Ruby purposely does not implement true multiple inheritance, but the mixin technique is a good alternative. Remember that modules cannot be instantiated or subclassed; but if we include a module in a class definition, its methods are effectively appended, or "mixed in", to the class.

Mixin can be thought of as a way of asking for whatever particular properties we want to have. For example, if a class has a working each method, mixing in the standard library's Enumerable module gives us sort and find methods for free.

This use of modules gives us the basic functionality of multiple inheritance but allows us to represent class relationships with a simple tree structure, and so simplifies the language implementation considerably (a similar choice was made by the designers of Java).
=end

 
