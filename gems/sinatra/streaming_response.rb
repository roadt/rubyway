

require 'sinatra'

get '/' do
  stream do |out|
    out << "It's gonna be legen -\n"
    sleep 0.5
    out << " (wait for it) \n"
    sleep 1
    out << "- dary!\n"
  end
end



# long polling

set :server, :thin
connections = []

get '/subscribe' do 
  # regsiter a client's intereset in server events
  stream(:keep_open) { |out| connections << out }
  
  # purege dead connections
  connections.reject!(&:closed?)

  # aknowlege
  "subscribed"
end


post '/message' do
  connections.each do |out|
    # ntoify client that a new messgea has arrived
    out << "[" << params[:message] << "]\n"
    
    # indicate client to connect again
    out.close
  end
  
  # acknowledge
  "message received"
end
