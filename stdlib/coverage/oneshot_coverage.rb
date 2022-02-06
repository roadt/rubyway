$:.unshift(File.expand_path('..', __FILE__))
#puts $:


require "coverage"
Coverage.start(oneshot_lines: true)
require "foo.rb"


#The value of the oneshot lines coverage result is an array containing the line numbers that were executed.
p Coverage.result #=> {"foo.rb"=>{:oneshot_lines=>[1, 2, 3, 6, 7]}}
