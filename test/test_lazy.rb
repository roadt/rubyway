require 'pp'


def create_array(n)
end

def lazy_map_iter(a)
    a.lazy.map{|a| {:a=>a[0], :b=>a[1]}}
end


def make_my_hash(arr)
    res = {}
    for e in arr do 
      res[:test] =e[0]
      res[:key] = e[1]
    end
  res
end


class C
  include Enumerable
  attr_accessor :obj, :args
  def initialize(iter, *args)
    self.obj = iter
    self.args = args
  end

  def each
    obj.each do |e|
      arr = []
      arr << e
      args.each {|t|
        arr << t.next
      }
      yield arr
    end
  end
end


      
    
  
c = C.new [1,2],[3,4],[5,6]
c.each { |e| pp  e }
