

class C
  def method_missing(*args)
    print  args
  end
end

c = C.new
c.call(1,3,4)
