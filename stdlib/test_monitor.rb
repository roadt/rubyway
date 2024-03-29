

require 'monitor'


buf = []

buf.extend(MonitorMixin)
empty_cond = buf.new_cond

# consumer

Thread.start do 
  loop do 
    buf.synchronize do
      empty_cond.wait_while { buf.empty? }
      puts buf.shift
    end
  end
end

# producer
while line = ARGF.gets
  buf.synchronize do
    buf.push(line)
    empty_cond.signal
  end
end

sleep 2
