
require 'sinatra'

# normal string



# others
#  valid rack rsponse, rack body object or http status code
# [ status, header, resonse body]
#[ status, response body(#each)]
# response boyd(#each)
# status (fixnum)

class Stream
  def each
    100.times { |i| yield "#{i}"}
  end
end

get('/') { Stream.new }


