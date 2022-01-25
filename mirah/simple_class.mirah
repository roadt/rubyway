

class SimpleClass
  def initialize
    puts "construstor"
    @hello = "Hello, "
  end
  
  def hello(a:String)
    puts @hello; puts a
  end
end

SimpleClass.new.hello("Mirah")
