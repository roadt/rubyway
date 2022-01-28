

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "/home/roadt/querying.sqlite"
)

class UserMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.integer :lock_version  # <-- need lock_version column
    end
  end
end


class User < ActiveRecord::Base

end


begin
  UserMigration.migrate :up

  20.times {
    User.create(:fname => "test", :lname => "test")
  }
  
  # optimistic locking
  u1 = User.find(1)
  u2 = User.find(1)

  print [u1.lock_version, u2.lock_version]
  u1.fname = 'xxx'
  u1.lname = 'xx2'
  print [u1.lock_version, u2.lock_version]
  u1.save

   User.find(1).tap{|e| e.fname='xx'}.save
  puts User.find(1).lock_version
  u2.lname = 'yyy'
  print [u1.lock_version, u2.lock_version]
  u2.save
  

ensure
  UserMigration.migrate :down
end

