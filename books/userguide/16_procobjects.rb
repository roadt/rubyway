
# new a procedure object using proc.
quux = proc {
  puts "QUUXQXZXCVXXXX!!"
}

# can call "call" method.
quux.call

# run
def run(p)
  puts "About to call a procedure..."
  p.call
  puts "There: finished."
end

run quux

#trap
inthandler = proc { puts "^C was pressed." }
trap "SIGINT", inthandler

# annonymouse equality
trap "SIGINT", proc { puts "^C was pressed."}
trap "SIGINT", 'puts "^C was pressed."'
