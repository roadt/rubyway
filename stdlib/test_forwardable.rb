
require 'forwardable'

#
class Records
  def initialize
    @records = [1,2,3]
  end

  extend Forwardable
  def_delegator :@records, :[], :record_number  # delegate :record_number to @records[]

end

recs = Records.new
recs.record_number(1)


#-- delegate > 1 methods
class Records
  def_delegators :@records, :size, :<<, :map  # delegate #size, #<<, #map to  @records..'s corresponding methods
end
recs.size
recs << 4
recs.map{|x| x}


#--- more example
printer = String.new
printer.extend Forwardable
printer.def_delegator "STDOUT", "puts"
printer.puts "Howdy!"


#-- delegate vs inheritence
# delegate can only delegate neccessary methdos not all methods

class Queue
  extend Forwardable
  def initialize
    @q = [ ]
  end

  def_delegator :@q, :push, :enq
  def_delegator :@q, :shift, :deq

  def_delegators :@q, :clear, :first, :push, :shift, :size
end
q = Queue.new
q.enq 1,2,3,4,5
q.push 6

q.shift # => 1
while q.size > 0
  puts q.deq
end

q.enq "Ruby", "Perl", "Python"
puts q.first
q.clear
puts q.first

