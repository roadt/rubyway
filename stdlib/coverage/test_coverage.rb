$:.unshift(File.expand_path('..', __FILE__))
#puts $:

require 'coverage'

Coverage.start
require 'foo.rb'

# A coverage array gives, for each line, the number of line execution by the interpreter. A nil value means coverage is disabled for this line (lines like else and end).
puts Coverage.result
