


include Arbre::HTML

#Attributes
at = Attributes.new
at[:id] = 'panel-id'
at[:key] = "value"
at[:name] = "mem"
at
puts at


#ClassList
cl = ClassList.new
cl.add("classa classb")
cl.add("classc classd")
cl
puts cl


