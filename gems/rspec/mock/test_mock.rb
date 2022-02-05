
require 'rspec'
require 'rspec/mocks'

RSpec::Mocks.setup(self)

# test double
book = double("book")

# method stubs
book.stub(:title) { "The RSpec Book" }
book.title
book.stub(:title => "The RSpec Book2")
book.title
book.stub(:title).and_return("The RSpec Book 3")
book.title

#
book = double("book", :title=>"The RSpec Book 4")
book.title

#
book = double(:foo => 'bar')
book.foo

#
[double(:price=>1.99), double(:price=>2.99)]

# consecutive return values
die = double()
die.stub(:roll).and_return(1,2,3)
die.roll
die.roll
die.roll
die.roll
die.roll

team = double()
team.stub(:players).and_return([double(:name=>"David")])
team.players.map(&:name)

## message expectaionts

validator = double("validator")
validator.should_receive(:validate).with("02134")
#zipcode =Zipcode.new("02134", validator)
#zipcode.valid?


## Nomenclature

# test specific extension
person = double("person")
class Person; end
Person.stub(:find) { person }
Person.find

person = double("person")
Person.should_receive(:find) { person } # fail if find is not called
Person.find


# expecting arguments
o = double()
o.should_receive(:msg).with(1,2,3)
o.should_not_receive(:msg).with(1,2,3)


o.should_receive(:msg).with("A", 1, 3)
o.should_receive(:msg).with("B", 2, 4)

# argument matchers
o.should_receive(:msg).with(no_args())
o.should_receive(:msg).with(any_args())
o.should_receive(:msg).with(1, kind_of(Numeric), "b") #2nd argument can be any kind of Numeric
o.should_receive(:msg).with(1, boolean(), "b") #2nd argument can be true or false
o.should_receive(:msg).with(1, /abc/, "b") #2nd argument can be any String matching the submitted Regexp
o.should_receive(:msg).with(1, anything(), "b") #2nd argument can be anything at all
o.should_receive(:msg).with(1, duck_type(:abs, :div), "b")
                    #2nd argument can be object that responds to #abs and #div

# receive counts
o.should_receive(:msg).once
o.should_receive(:msg).twice
n  = 5
o.should_receive(:msg).exactly(n).times
o.should_receive(:msg).at_least(:once)
o.should_receive(:msg).at_least(:twice)
o.should_receive(:msg).at_least(n).times
o.should_receive(:msg).at_most(:once)
o.should_receive(:msg).at_most(:twice)
o.should_receive(:msg).at_most(n).times
o.should_receive(:msg).any_number_of_times

# ordering

o.should_receive(:msg).ordered
o.should_receive(:other_msg).ordered
  #This will fail if the messages are received out of order

o.should_receive(:msg).with("A", 1, 3).ordered
o.should_receive(:msg).with("B", 2, 4).ordered

#  setting responses
value = 'im value'
o.should_receive(:msg) { value }
o.should_receive(:msg).and_return(value)
o.should_receive(:msg).exactly(3).times.and_return(1,2,3)
  # returns value1 the first time, value2 the second, etc
o.should_receive(:msg).and_raise(StandardError.new)
  #error can be an instantiated object or a class
  #if it is a class, it must be instantiable with no args
o.should_receive(:msg).and_throw(:msg)
o.should_receive(:msg).and_yield(values,to,yield)
o.should_receive(:msg).and_yield(values,to,yield).and_yield(some,other,values,this,time)
  # for methods that yield to a block multiple times
o.msg


# arbitrary handling

o.should_receive(:msg) do |arg|
  arg.size.should eq(7)
end
o.msg 1,2

# delegating to the original implementation
Person.should_receive(:find).and_call_original
Person.find # => executes the original find method and returns the result

#combining expectation details

o.should_receive(:<<).with("illegal value").once.and_raise(ArgumentError)
o << 1
o << 'illegal value'

# stubbing and hide constant

# use 'before(:each)', not 'before(:all)'(not supported)
