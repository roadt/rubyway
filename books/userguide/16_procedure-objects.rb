

#It is often desirable to be able to specify responses to unexpected events. As it turns out, this is most easily done if we can pass blocks of code as arguments to other methods, which means we want to be able to treat code as if it were data.

# A new procedure object is formed using proc:
puts quux = proc {
puts "QUUXQUUXQUUX!!!"
}

#Now what quux refers to is an object, and like most objects, it has behavior that can be invoked. Specifically, we can ask it to execute, via its call method:
quux.call

#So, after all that, can quux be used as a method argument? Sure.
def run(p)
puts "About to call a procedure..."
p.call
puts "There: finished."
end

run quux

#The trap method lets us assign the response of our choice to any system signal.
puts inthandler = proc { puts "^C was pressed" }
trap "SIGINT", inthandler

#anonymous procedure object would look like
trap "SIGINT", proc{ puts "^C was pressed." }
#more compactly still
trap "SIGINT", 'puts "^C was pressed." '
