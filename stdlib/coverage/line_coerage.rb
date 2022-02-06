$:.unshift(File.expand_path('..', __FILE__))
#puts $:


require "coverage"
Coverage.start(lines: true)
require "foo.rb"


p Coverage.result #=> {"foo.rb"=>{:lines=>[1, 1, 10, nil, nil, 1, 1, nil, 0, nil]}}
#The value of the lines coverage result is an array containing how many times each line was executed. 
#Order in this array is important. For example, the first item in this array, at index 0, reports how many times line 1 of this file was executed while coverage was run (which, in this example, is one time).
