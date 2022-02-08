

require 'haml'

def haml(src, this, context)
  engine = Haml::Engine.new(src)
  engine.render this,context
end

class C
  def initialize
    @a = 1
  end
end
puts haml ".a\n  .b=a\n  .c=@a", C.new,  {a:'xx'}
