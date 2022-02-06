$:.unshift(File.expand_path('..', __FILE__))
#puts $:

require "coverage"
Coverage.start(:all)
require "foo.rb"
p Coverage.result #=> {"foo.rb"=>{:lines=>[1, 1, 10, nil, nil, 1, 1, nil, 0, nil], :branches=>{[:if, 0, 6, 0, 10, 3]=>{[:then, 1, 7, 2, 7, 7]=>1, [:else, 2, 9, 2, 9, 7]=>0}}, :methods=>{}}}
