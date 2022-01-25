

require 'delegate'

# simple delegator
arr = []
d = SimpleDelegator.new arr
d << 1 << 2 << 3
puts arr

# Delegate Class
class ArrayProxy < DelegateClass(Array)  # step 1
  def initialize arr
    @arr = arr
    super(@arr)  # step2
  end
end
arr2 = []
d2 = ArrayProxy.new  arr2
d2 << 3 << 2 << 1
arr2

