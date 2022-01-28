

require 'active_record'

 	
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "test.sqlite")

class  CreateProduct < ActiveRecord::Migration
  
  def change
    create_table :products do |t|
      t.primary_key :id
      t.string :name
      t.text :description
      
      t.timestamps
    end
  end
end

M = CreateProduct
puts M.verbose = true
M.migrate :up
M.migrate :down
