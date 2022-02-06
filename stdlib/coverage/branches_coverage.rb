$:.unshift(File.expand_path('..', __FILE__))
#puts $:


#Branches coverage reports how many times each branch within each conditional was executed.
require "coverage"
Coverage.start(branches: true)
require "foo.rb"


=begin
Each entry within the branches hash is a conditional, the value of which is another hash where each entry is a branch in that conditional. 
The values are the number of times the method was executed, and the keys are identifying information about the branch.

The information that makes up each key identifying branches or conditionals is the following, from left to right:

    A label for the type of branch or conditional.

    A unique identifier.

    The starting line number it appears on in the file.

    The starting column number it appears on in the file.

    The ending line number it appears on in the file.

    The ending column number it appears on in the file.

=end
p Coverage.result #=> {"foo.rb"=>{:branches=>{[:if, 0, 6, 0, 10, 3]=>{[:then, 1, 7, 2, 7, 7]=>1, [:else, 2, 9, 2, 9, 7]=>0}}}}
