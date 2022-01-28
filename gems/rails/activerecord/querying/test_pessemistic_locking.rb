

require 'logger'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "/home/roadt/querying.sqlite")

ActiveRecord::Base.establish_connection(
  adapter:  "pg",
  host: 'localhost',                                        
  database: "test",
  username: "roadt",
  password:'pass')


ActiveRecord::Base.logger = Logger.new STDOUT

class UserMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.integer :age
    end
  end
end


class User < ActiveRecord::Base

end


begin
  UserMigration.migrate :up

  User.transaction do 
    20.times {
      User.create(:fname => "test", :lname => "test")
    }
  end
  
  # pessemistic locking
  User.transaction do 
    u = User.lock.first
    u.lname = 'rrrrr'
    u.save
  end

  User.transaction do
    i = User.lock("LOCK IN SHARE MODE").find(1)
    i.increment!(:age)
  end
ensure
  UserMigration.migrate :down
end

