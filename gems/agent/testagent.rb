

require 'agent'

@c1 = Agent.channel! (Integer)
@c2 = Agent.channel! (Integer)

def fact (n)
  sum = 1
  while n > 0 do
    sum = sum *n
    n -= 1
  end
  sum
end

go! do
  loop { 
    i =  @c1.receive.first
    @c2 <<  fact(i) 
  }
end


def asynfact(n)
  @c1 << n
  @c2.receive.first
end


