


class Ambiguous
  def x; 1; end # A method named "x". Always returns 1
  def test
    puts x      # No variable has been seen; refers to method above: prints 1
    # The line below is never evaluated, because of the "if false" clause. But
    # the parser sees it and treats x as a variable for the rest of the method.
    x = 0 if false
    puts x    # x is a variable, but has never been assigned to: prints nil
    x = 2     # This assignment does get evaluated
    puts x    # So now this line prints 2
    puts x()  # use () to explicit call method
  end
end

Ambiguous.new.test


C = 1
C = 2
D = nil


class Fn 
  def [](x,y)
    x*x + y*y
  end

  def []=(x,y,z)
    z
  end
end

f = Fn.new
puts  f[1,2], f[3,4], f[7,8]


puts f[1,2] -= 2



    
