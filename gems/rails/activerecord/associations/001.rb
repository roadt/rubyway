

require 'active_record'
require 'pp'

ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "assocs.sqlite"
)

class Migration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.primary_key :id
      t.string :name
      t.references :group
    end

    create_table :groups do|t|
      t.primary_key :id
      t.string :name
    end
    

    create_table :accounts do |t|
      t.primary_key :id
      t.string :name
      t.references :user
    end

  end
end


class User < ActiveRecord::Base
  has_one :account
  belongs_to :group
end

class Group < ActiveRecord::Base
  has_many :users
end

class Account < ActiveRecord::Base
  belongs_to :user
end


begin
  Migration.migrate :up

  3.times {|i|
    g = Group.create(:name => "group#{i}")
    u = User.create(:name => "user#{i}", :group => g)
    Account.create(:name=>"acc#{i}", :user => u) 
  }
  u = User.find(1)
  g = Group.find(1)


  pp User.all
  pp Group.all
  pp Account.all

  puts 
  pp u.group
  pp u.account
  pp g.users.map(&:account)


  ##  obj added to collection means obj saved.
  g.users << User.new(:name => "usernew1")
  pp g.users
  pp User.all # the new user is there.

  ###   destory parent ,doesnt' destory assocs by default (can override)
  u.account = Account.new(:name=>"accnew1")
  u.destroy
  pp u.account
  pp Account.all
  pp User.all
rescue => ex
  puts ex
ensure
  Migration.migrate :down
end


