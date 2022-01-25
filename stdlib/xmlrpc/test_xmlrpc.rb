

require 'xmlrpc/client'
require 'pp'

server = XMLRPC::Client.new2("http://xmlrpc-c.sourceforge.net/api/sample.php")

begin
  result = server.call("sample.sumAndDifference", 5, 3)
  pp result
rescue XMLRPC::FaultException => e
  puts "Error: "
  puts e.faultCode
  puts e.faultString
end



# server = XMLRPC::Client.new2("http://venus:8069/xmlrpc/common")
# server.call("login", "demo", "admin", 'pass')

# obj =  XMLRPC::Client.new2("http://venus:8069/xmlrpc/object")
# obj.call("demo", "admin","Product", "search", "vat = 1")
# obj.call("Project.read","demo", "roadt",  [1,2], ['c'])


