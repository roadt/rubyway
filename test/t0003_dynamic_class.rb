

#  Can ruby create class from data(cfg data), e.g a array?
#
#  OK, it can.  the key here is  class is open and the create class utility method is injectable (with block).


names  = [:a, :b, :name, :ok]

C = Class.new do 
  names.each do |x|
    attr_accessor x
  end
end

puts C.instance_methods false
