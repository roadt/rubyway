require 'singleton'


class TestSingleton
  include Singleton
end

ObjectSpace.each_object(TestSingleton){}

a, b = TestSingleton.instance, TestSingleton.instance
a == b    # true

ObjectSpace.each_object(TestSingleton){}


# == Implementation
#
# This above is achieved by:
#
# *  Making Klass.new and Klass.allocate private.
#
# *  Overriding Klass.inherited(sub_klass) and Klass.clone() to ensure that the
#    Singleton properties are kept when inherited and cloned.
#
# *  Providing the Klass.instance() method that returns the same object each
#    time it is called.
#
# *  Overriding Klass._load(str) to call Klass.instance().
#
# *  Overriding Klass#clone and Klass#dup to raise TypeErrors to prevent
#    cloning or duping.
#


# == Singleton and Marshal
#
# By default Singleton's #_dump(depth) returns the empty string. Marshalling by
# default will strip state information, e.g. instance variables and taint
# state, from the instance. Classes using Singleton can provide custom
# _load(str) and _dump(depth) methods to retain some of the previous state of
# the instance.

class Example
  include Singleton
  attr_accessor :keep, :strip
  def _dump(depth)
    # this strips the @strip information from the instance
    Marshal.dump(@keep, depth)






