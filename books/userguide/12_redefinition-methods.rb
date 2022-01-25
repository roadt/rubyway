

#In a subclass, we can change the behavior of the instances by redefining superclass methods.
class Human
  def identify
    puts "I'm a person."
  end
  def train_toll(age)
      if age < 12
        puts "Reduced fare.";
      else
        puts "Normal fare.";
      end
  end
end

 Human.new.identify

class Student1<Human
  def identify
    puts "I'm a student."
  end
end

 Student1.new.identify

#Suppose we would rather enhance the superclass's identify method than entirely replace it. For this we can use super.
class Student2<Human
  def identify
    super
    puts "I'm a student too."
  end
end

 Student2.new.identify


#super lets us pass arguments to the original method. It is sometimes said that there are two kinds of people...
class Dishonest<Human
  def train_toll(age)
    super(11) # we want a cheap fare
  end
end

Dishonest.new.train_toll(25)


class Honest<Human
  def train_toll(age)
    super(age) #pass the argumetn we were given
  end
end

Honest.new.train_toll(25)
