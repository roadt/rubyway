

require 'sinatra'

# passing
# skip curretn ruote to next amtching route

get '/guess/:who' do 
  pass unless params[:who] == 'Frank'
  'You got me!'
end

get '/guess/*' do 
  'You missed!'
end

