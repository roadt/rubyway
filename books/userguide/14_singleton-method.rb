=begin
The behavior of an instance is determined by its class, but there may be times we know that a particular instance should have special behavior. In most languages, we must go to the trouble of defining another class, which would then only be instantiated once. In ruby we can give any object its own methods.
=end
class SingletonTest
  def size
    25
  end
end

test1 = SingletonTest.new
test2 = SingletonTest.new

def test2.size
  10
end

puts test1.size
puts test2.size


=begin
In this example, test1 and test2 belong to same class, but test2 has been given a redefined size method and so they behave differently. A method given only to a single object is called a singleton method.

Singleton methods are often used for elements of a graphic user interface (GUI), where different actions need to be taken when different buttons are pressed.

Singleton methods are not unique to ruby, as they appear in CLOS, Dylan, etc. Also, some languages, for example, Self and NewtonScript, have singleton methods only. These are sometimes called prototype-based languages.
=end
