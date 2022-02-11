# -*- coding: utf-8 -*-

require 'builder'

xml = Builder::XmlMarkup.new

# xml comemnt
xml.comment! "This is a comment"

# xml processing instructions  
xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"  # 1.0, UTF-8 default vallue.

# entity decl
#xml.declare! :DOCTYPE, :chapter, :SYSTEM, "../dtds/chapter.dtd"
#xml.declare! :ELEMENT, :chapter, :"(title, para+)"

#namespace
# 1st symboll params is ns
xml.SOAP :Envelope do   
end

#
xml.sample(:escaped => "THis & That", :unescaped=>:"Here&amp;There")
xml.target! 

# utf-8 support (instruct!)
xml.sample("Iñtërnâtiônàl")


# demo
xml.a :ns, :id=>1 do
  xml.name "my name"
  xml.flag true
  xml.b do
    xml.id = 1
  end
end

xml.a  do |a|
  a.name  "another name"
  a.flag false
  a.b do|b|
    b.name "i'm ok too"
  end
end
    
