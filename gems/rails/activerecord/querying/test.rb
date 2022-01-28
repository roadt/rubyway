

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "/home/roadt/querying.sqlite"
)

class UserMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.primary_key :id
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

  u1.fname = 'xxx'
  u1.save

  u2.lname = 'yyy'
  u2.save

ensure
  UserMigration.migrate :down
end

