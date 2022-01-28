
gem 'activerecord', '~> 3.2.13'
require 'active_record'

ActiveRecord::Base.establish_connection(  adapter:  "sqlite3",  database: "/home/roadt/activerecord.sqlite")

class UserMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
#      t.primary_key :id
      t.string :fname
      t.string :lname
#      t.integer :lock_version  # <-- need lock_version column
    end
  end
end


class User < ActiveRecord::Base
  attr_accessible :fname, :lname

  ### 9.1 callback registration
  validates :fname, :lname, :presence => true
  before_validation :msg_before_validation
  def msg_before_validation
    puts "#{self.fname} before validation"
  end

  before_create do |user|  # block form.
    puts "#{self.fname} before_create block form"
  end

  ### available callbacks
  before_validation do |user|
    puts "before validation #{user}"
  end
  after_validation do |user|
    puts "after validation #{user}"
  end

  before_create do |user|
    puts "before_create #{user.fname}"
  end
  # around_create do |user|
  #   puts "around_create #{user.fname}"
  #   yield
  # end
  after_create do |user|
    puts "after_create #{user.fname}"
  end

  before_save do |user|
    puts "before_save #{user.fname}"
  end
  # around_save do |user|
  #   puts "around_save #{user.fname}"
  #   yield
  # end
  after_save do |user|
    puts "after_save #{user.fname}"
  end


  before_update do |user|
    puts "before_update #{user.fname}"
  end
  # around_update do |user|
  #   puts "around_update #{user.fname}"
  #   yield
  # end
  after_update do |user|
    puts "after_update #{user.fname}"
  end
  

  before_destroy do |user|
    puts "before_destroy #{user.fname}"
  end

  ##  it proves that
  # 1,  if add yiled to around_xxx callback, error occurs.
  # 2,  if around_xxx callback exists, the xxxx (e.g. destroy) will not work. (so comment out)

  # around_destroy do |user|
  #   puts "around_destroy #{user.fname}"
  # end


  after_destroy do |user|
    puts "after_destroy #{user.fname}"
  end
  

  def msg_created
    puts "#{self.fname} created"
  end

  def msg_destroyed
    puts "#{self.fname} destoryed"
  end

    
end


begin
  UserMigration.migrate :up

  5.times {|i|
    User.create(:fname => "ftest#{i}", :lname => "ltest#{i}").save
  }
  
  # optimistic locking
  puts User.all.map(&:fname)
  u1 = User.first
  u1.fname = 'xxx'
  u1.save
  u1.destroy

  User.all.each{|e|   e.destroy  }
  puts User.count
ensure
  UserMigration.migrate :down
end





