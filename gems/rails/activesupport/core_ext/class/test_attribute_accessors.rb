gem 'activesupport', '~> 3.2.13'

require 'active_support/all'

class C
  cattr_accessor :a
end

class D < C
  cattr_accessor :a
end
C.a = 1
C.a

D.a
D.a =2
C.a  #  => 2  -  set D.a changed C.a
