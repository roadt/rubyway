

require 'yaml'
require 'pp'

o1 =  YAML.load_file('items.yml')
pp o1
o2 = YAML.parse_file('items.yml')
pp o2

pp YAML.load_file('refcard.yml')
