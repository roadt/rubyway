
gem 'activerecord', '3.2.13'
require 'active_record'
reuqire 'pp'

ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "/home/roadt/querying.sqlite"
)

class UserMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
    end
  end
end


class User < ActiveRecord::Base

end


begin
  UserMigration.migrate :up

  20.times {
    User.create(:name => "test")
  }


  User.find_each do |e|
    print e.id
  end
  puts 

  User.find_each :start => 10 do |e|
    print e.id
  end
  puts


ensure
  UserMigration.migrate :down
end


