gem 'activesupport', '~> 3.2.13'
require 'active_support/all'

class C
  class_attribute :a
end
C.a
C.a = 1
C.a

class D< C
end
D.a
D.a = 2
D.a
C.a

class D < C
  class_attribute  :a
end

D.a
C.a
D.a =2
C.a  #  => 2  -  set D.a changed C.a


# 
class E< D
end
E.a  #=> 2   E.a inheirt D.a value, E automatically got a getter,setter
E.a = 3
E.a #=> 3
D.a # => 2
C.a # => 1
