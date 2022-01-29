

require 'sinatra'

class All
  def match(str)
    self
  end

  def captures
    ['a', 'b']
  end
end


# the retobj should has `#match' , which return  #to_a or array object.
def all()
    All.new
end

get all() do
 "Hello world #{params} "
end
