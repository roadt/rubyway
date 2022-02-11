
gem 'arbre'
require 'arbre'



# simple usage
html = Arbre::Context.new do
  h2 "Why is Arbre awesome?"
  
  ul do
    li "The DOM is implement by ruby"
    li "You can create object oritned views"
    li "Template suck"
  end
end


puts html.to_s 

'''
<h2>Why is Arbre awesome?</h2>
<ul>
  <li>The DOM is implement by ruby</li>
  <li>You can create object oritned views</li>
  <li>Template suck</li>
</ul>
 => nil 
'''


#  dom in ruby (arbre leave view as ruby obj as long as possible)

html = Arbre::Context.new do
  h2 "Why Arbre is awesome?"
end

html.children.size
html.children.first



## Components

class Panel < Arbre::Component
  builder_method :panel
  
  def build(title, attributes = {})
    super(attributes)
    h3(title, class: "panel-title")
  end
  
end

html = Arbre::Context.new do
  panel 'Hello World', id: 'my-panel' do
    span 'Inside the panel'
  end
end

puts html.to_s

'''
<div class="panel" id="my-panel">
  <h3 class="panel-title">Hello World</h3>
  <span>Inside the panel</span>
</div>
'''

## Text Nodes

html = Arbre::Context.new do
  panel "hello world", id: 'my-panel' do
    span 'Inside the panel'
    text_node 'Plain text'
  end
end

puts html.to_s

'''
<div class="panel" id="my-panel">
  <h3 class="panel-title">hello world</h3>
  <span>Inside the panel</span>
Plain text</div>
'''



