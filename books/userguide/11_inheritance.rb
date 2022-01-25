

=begin
Our classification of objects in everyday life is naturally hierarchical. We know that all cats are mammals, and all mammals are animals. Smaller classes inherit characteristics from the larger classes to which they belong. If all mammals breathe, then all cats breathe.
=end

class Mammal
  def breathe
    puts "inhale and exhale"
  end
end

class Cat<Mammal
  def speak
    puts "Meow"
  end
end

=begin
Though we didn't specify how a Cat should breathe, every cat will inherit that behavior from the Mammal class since Cat was defined as a subclass of Mammal. (In OO terminology, the smaller class is a subclass and the larger class is a superclass.) Hence from a programmer's standpoint, cats get the ability to breathe for free; after we add a speak method, our cats can both breathe and speak.
=end

tama = Cat.new
tama.breathe
tama.speak


=begin
There will be situations where certain properties of the superclass should not be inherited by a particular subclass. Though birds generally know how to fly, penguins are a flightless subclass of birds.
=end

class Bird
  def preen
    puts "I am cleaning my feathers."
  end
  def fly 
    puts "I am flying"
  end
end

class Penguin<Bird
  def fly
    fail "Sorry. I'd rather swim."
  end
end

=begin
Rather than exhaustively define every characteristic of every new class, we need only to append or to redefine the differences between each subclass and its superclass. This use of inheritance is sometimes called differential programming. It is one of the benefits of object-oriented programming.
=end
