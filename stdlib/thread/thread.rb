
# Thread.new
t1 = Thread.new {
  puts 'this is thread1'
  print  Thread.current
  'thread1 -end'.tap {|x| puts x}
}

puts 'thread 2!'
print Thread.current


t1.join 

puts t1.value


# Thread.current, Thread.main, Thread.list
print [Thread.current, Thread.main]
puts

Thread.new {
  print [Thread.current, Thread.main, Thread.list]
  puts
}.join



#script stop, when mean thread is done. so need join
def join_all
  main = Thread.main        # The main thread
  current = Thread.current  # The current thread
  all = Thread.list         # All threads still running
  # Now call join on each thread
  all.each {|t| t.join unless t == current or t == main }
end

