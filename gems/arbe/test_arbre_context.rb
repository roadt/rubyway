

gem 'arbre'
require 'arbre'

include Arbre

Context.methods

c = Context.new
c.assigns
c.helpers

c.cached_html

c.h1

c.form method: :get, action: 'xxx' do 
  input id: 23
  
end

Context.new do
  form method: :get, action: 'xxx' do
    input id: 'id2'
  end
end
