
# local variable
# name starts with a lowr case letteer or an underscore charcer (_). 
# don't have nil before initaliziation

puts $foo
puts @foo
#puts foo - error

# first assignment is taken as decalration

# scope of local variable is one of 
# proc {...}
# loop {...}
# def ... end
# class ... end
# module ... end

# defined? is an operator to check whether an identifier is defined. rets identifer description or nil.


foo = 44
puts foo 
puts defined?(foo)

# loop {..}
# you see, bar's scope is local to the loop, bar is undefined when loop exists.
loop { bar =45; puts bar; break; }
puts defined?(bar)

#proc {...}
# proc object live in the same scope shared whatever local variables also belong to that scope.
bar=nil
p1 = proc {|n| bar=n}
p2 = proc{puts bar}
p1.call(5)
puts bar
p2.call
