
gem 'activejob'
require 'activejob'
require 'awesome_print'

class Job1 < ActiveJob::Base
  def perform *args
    ap args
  end
end


class Adapter 
  def enqueue(job)
    ap job
    return "sss"
  end
end
ActiveJob::Base.queue_adapter  = Adapter.new




