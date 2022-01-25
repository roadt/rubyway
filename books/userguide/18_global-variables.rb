

puts $foo
$foo = 5
puts $foo

trace_var :$x, proc{puts "$x is now #{$x}"}
$x = 5


# predefined globals variables

#  $! - last error message
#  $@ - location of errr
# $_  - string last read by gets
# $. -  line number last read by interpreter

# $& - string last matched by regexp
# $~ - the last regexp match, as an array of subexpresions
# $n - the nth subexpresion in the last match (same as $~[n])

# $=  - case-insensitivity flag
# $/ - input record separator
# $\  - output record separator
# $0 - the name of the ruby script file
# $* - the command line arguments
# $$ - interpreter's process ID
# $? - exit status of last executed child process

# $_ and $~ have local scope. has historical reasona and also  useful this ways.
