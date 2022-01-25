


require 'benchmark'


# The Benchmark module provides methods to measure and report the time
# used to execute Ruby code.
#
# * Measure the time to construct the string given by the expression
#   <code>"a"*1_000_000</code>:
#

puts Benchmark.measure {   "a"*1_000_000_000 }


#   This report shows the user CPU time, system CPU time, the sum of
#   the user and system CPU times, and the elapsed real time. The unit
#   of time is seconds.
#
# * Do some experiments sequentially using the #bm method:
n = 5000000
Benchmark.bm do |x|
  x.report  { for i in 1..n ; a = "1"; end}
  x.report { n.times do ; a = "1" ;end}
  x.report { 1.upto(n) do ; a = "1"; end}
end



Benchmark.bm(7) do |x|
  x.report("for:") { for i in 1..n ; a = "1"; end}
  x.report("times:") { n.times do ; a = "1" ;end}
  x.report("upto:") { 1.upto(n) do ; a = "1"; end}
end



################
# * The times for some benchmarks depend on the order in which items
#   are run.  These differences are due to the cost of memory
#   allocation and garbage collection. To avoid these discrepancies,
#   the #bmbm method is provided.  For example, to compare ways to
#   sort an array of floats:
#

array = (1..1000000).map { rand }

Benchmark.bmbm do |x|
  x.report("sort!") { array.dup.sort! }
  x.report("sort")  { array.dup.sort  }
end


# * Report statistics of sequential experiments with unique labels,
#   using the #benchmark method:
#
#       require 'benchmark'
include Benchmark         # we need the CAPTION and FORMAT constants
n = 50000
Benchmark.benchmark(CAPTION, 7, FORMAT, ">total:", ">avg:") do |x|
  tf = x.report("for:")   { for i in 1..n; a = "1"; end }
  tt = x.report("times:") { n.times do   ; a = "1"; end }
  tu = x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
  [tf+tt+tu, (tf+tt+tu)/3]
end
