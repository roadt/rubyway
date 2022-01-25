


require 'yaml/store'
require 'pp'

Person = Struct.new :first_name, :last_name
people = [Person.new("Bob", "Smith"), Person.new("Mary", "Johson")]

store = YAML::Store.new "test.yml"

store.transaction do
  store['people'] = people
#  store.abort
  store['greeting'] = {'hello'=> 'world'}
end


store.transaction(true) do 
  store.roots.each do |name|
    puts name
    pp store[name]
  end
end
  
