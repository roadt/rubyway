
require 'active_record'

class Product  < ActiveRecord::Base
  establish_connection :adapter => 'sqlite3', :database => 'readme.sqlite'
  connection.create_table table_name, :force=>true do |t|
    t.string :name
  end
end



p = Product.create!(:name => 'Bootle')
puts Product.all.inspect
p.destroy
puts Product.all.inspect
