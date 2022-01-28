require 'active_support/core_ext/module/attr_internal'
require 'pp'


class A
  attr_internal  :a, :b
end
a = A.new
a.a = a.b = 1
a.instance_variables
[a.a, a.b]


class A
  attr_accessor :c, :d
end
a = A.new
a.c  =  a.d = 2
a.instance_variables
[a.c, a.d]

