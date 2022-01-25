
class Dog
  def speak
    puts "Bow Wow"
  end
end

pochi = Dog.new
pochi.speak

#Dog.speak 
#ERR: (eval):1: undefined method `speak' for Dog:class

(Dog.new).speak
Dog.new.speak

