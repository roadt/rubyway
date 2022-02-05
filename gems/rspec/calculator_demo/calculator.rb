

class Calculator
  
  def add(*args)
    args.reduce(&:+)
  end
end
  
