gem 'active_record', '~>4.2.7.1'
require 'active_record/all'
require 'pp'


ENV['DATABASE_URL'] = 'mysql2://roadt:pass@localhost/test'
ActiveRecord::Base.establish_connection
class CreateTable < ActiveRecord::Migration
  def up
    create_table :bs do |t|
      t.timestamps
    end
  end
    
  def down
    drop_table :bs
  end
end
M = CreateTable
puts M.verbose = true
M.migrate :up
M.migrate :down

class B < ActiveRecord::Base
  establish_connection
end

10.times { b.create! }

 B.find 2




