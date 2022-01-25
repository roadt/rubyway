

require 'erb'


a = 1
erb = ERB.new " safasfasfd <%= a %> ..."

erb.src
erb.result binding


class C

  def self.element name, opts = {}, &block
    template = <<-EOF
def <%=name%>()
   puts "name"
  <% if opts[:selector] %>
       puts "selector"
 <% end %>
   <% if opts[:attr] %>
      puts "attr"
   <% end %>
    <% if opts[:regex] %>
            puts "regex"
    <%end%>
 end
EOF
    erb = ERB.new(template)
    result = erb.result(binding)
    class_eval result, __FILE__, __LINE__ + 1
  end
end



class D <  C
  element "name"
  element "author", :selector => ".tb_icon_author a", :attr => 'href' , :regex => "/test=(.*)/"
end

D.new.name
puts '---'
D.new.author
    
