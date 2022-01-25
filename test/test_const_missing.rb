



class C
  def self.const_missing(*args)
    print args
    self
  end
end

C::B
C::B::A
