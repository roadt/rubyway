


=begin
A constant has a name starting with an uppercase character. It should be assigned a value at most once. In the current implementation of ruby, reassignment of a constant generates a warning but not an error (the non-ANSI version of eval.rb does not report the warning):
=end

puts fluid = 30
puts fluid = 31
puts Solid = 32
#puts Solid = 33 # warning: already initialized constant Solid


#Constants may be defined within classes, but unlike instance variables, they are accessible outside the class.
class ConstClass
C1 = 101
C2 = 102
C3 = 103
def show
puts "#{C1} #{C2} #{C3}"
end
end


#puts C1 #uninitialized constant C1 (NameError)
puts ConstClass::C1
puts ConstClass.new.show



#Constants can also be defined in modules.

module ConstModule
C1=101
C2=102
C3=103
def showConstants
puts "#{C1} #{C2} #{C3}"
end
end

include ConstModule
puts C1
puts showConstants
puts C1=99  # not really a good idea
puts C1
puts ConstModule::C1
puts ConstModule::C1 = 99  # not allowed in earilier version
puts ConstModule::C1   # ennough rope to shoot yourself in the root
