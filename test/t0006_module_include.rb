


# test1
class C
  def f
    'C.f'
  end
end

module M
  def f
    'M.f'
  end
end


class D < C
  include M
end


puts D.new.f
# result   include will override class methods


# test2
class C1
  include M
  def f
    'C1.f'
  end
end

class C2
  def f
    'C2.f'
  end
  include M
end
puts C1.new.f
puts C2.new.f
# result -  include order doesn't affect call order

