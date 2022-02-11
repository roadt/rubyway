
gem 'arbre'
require 'arbre'


include Arbre

#Elements

e = Element.new
e.assigns
e.helpers
e.tag_name

e.build(1,2) do |e|
  e.tag_name
end

e.add_child(Element.new)
e << Element.new
e.children
e.children?

e.parent
e.parent= Element.new
e.ancestors
e.content
e.html_safe
e.indent_level

e.each do |i|
  puts i
end


