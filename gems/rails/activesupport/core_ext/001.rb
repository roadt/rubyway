
require 'active_support/core_ext'

class C
  class_attribute :a, :b
end
C.a = C.b = 1
print(C.a, C.b)
print(C.a?, C.b?)


