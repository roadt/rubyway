$:.unshift(File.expand_path('..', __FILE__))
#puts $:

#Methods coverage reports how many times each method was executed.
require "coverage"
Coverage.start(methods: true)
require "foo_method.rb"

=begin
Each entry within the methods hash represents a method. The values in this hash are the number of times the method was executed, and the keys are identifying information about the method.

The information that makes up each key identifying a method is the following, from left to right:

    The class.

    The method name.

    The starting line number the method appears on in the file.

    The starting column number the method appears on in the file.

    The ending line number the method appears on in the file.

    The ending column number the method appears on in the file.
=end
p Coverage.result #=> {"foo_method.rb"=>{:methods=>{[Object, :hello, 7, 0, 9, 3]=>1, [Greeter, :greet, 2, 2, 4, 5]=>1}}}
