

#
#  ruby coerce.
#
#  1 + x 
#  -> y =  x.ceorce(1) 
#  -> x + y
#
# i.e. first use x's coerce to convert 1 to x instance. 
# use call x's *op* method to get final result.
#  

class C
  def initialize(v=1)
    @v = v
  end

  def coerce(value)
    print [self,value]
    [self, C.new(value)]
  end

  def +(v)
    C.new(@v + v.instance_variable_get(:@v))
  end

  def to_s
    "C(#{@v})"
  end
end

c = C.new
1 + c
