gem 'mysql', '~>2.8'
gem 'activerecord' , '3.2.13'


require 'active_record'
require 'pp'

#ActiveRecord::Base. establish_connection(:adapter=>'sqlite3', :database => 'validation.sqlite3')
ActiveRecord::Base. establish_connection(:adapter=>'mysql', :database => 'test')


class CreateItem < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.integer :int,  :default => 1
      t.string :str
      t.text :text

      #t.timestamps
    end
  end
    
  def down
    drop_table :items
  end
end

CreateItem.migrate :down
CreateItem.migrate :up

class Item < ActiveRecord::Base
  validate  :int,  inclusion: { in: %w(1 2 3) }
end


