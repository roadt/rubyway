

require 'active_record'
require 'base64'

#ENV['DATABASE_URL'] = 'mysql2://roadt:pass@localhost/test'
#ENV['DATABASE_URL'] = "sqlite3:///home/roadt/blob.sqlite"

ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "/home/roadt/blob.sqlite"
)

class Blob < ActiveRecord::Base
#  establish_connection 
end

#Blob.first_or_create(:data=> (File.read("/home/roadt/1"))).save!
#Blob.new(:data=> Base64.encode64(File.read("/home/roadt/1"))).save!
b = Blob.new
b.data = File.read("/home/roadt/1")
b.save!
puts   Blob.first.data.size




