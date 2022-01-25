

require 'observer'

class Callback
  def update(*args)
    puts args
  end
end

class Timer
  include Observable

  def initialize cb
    add_observer(cb)
  end

  def run
    loop do 
      changed
      notify_observers(Time.now)
      sleep 1
    end
  end
end

t = Timer.new Callback.new
t.run
