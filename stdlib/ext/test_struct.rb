

# use 1
Struct.new('Customer', :name, :address)
Struct::Customer.new('Dave', '123 Main')

# use2
Customer = Struct.new(:name, :address)
Customer.members
c = Customer.new('Dave', '123 Main')

c == Customer.new('Dave', '123 Main')
c.hash
c.to_s
c.to_a
c.values
c.size
c.length

c.each {|*o| print o}
c.each_pair {|*o| print o}

c[:name]
c['name']
c
c[:address] = '234 main'
c

c.select {|*o| print o}
c.select {|o|  o == 'Dave'}

c.values_at(0, 1)
c.values_at(1, 1)

c.members

c == Struct::Customer.new('Dave', '123 Main')


