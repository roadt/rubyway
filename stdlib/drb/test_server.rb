require 'drb/drb'

URI = 'druby://localhost:8787'

class TimeServer

  def current
    Time.now
  end
end

FRONT_OBJ = TimeServer.new

$SAFE = 1

DRb.start_service(URI, FRONT_OBJ)

DRb.thread.join
