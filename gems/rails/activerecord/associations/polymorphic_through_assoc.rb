
gem 'activerecord', '~>3.0'

require 'active_record'
require 'pp'
require 'minitest/unit'


ActiveRecord::Base.establish_connection(
                                        adapter:  "sqlite3",
                                        database: "assocs.sqlite"
                                        )

class Migration < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.primary_key :id
      t.string :name
    end

    create_table :groups do|t|
      t.primary_key :id
      t.string :name
    end
    
    create_table :tags do |t|
      t.primary_key :id
      t.string :name 
      t.string :type
    end

    create_table :relationships do |t|
      t.primary_key :id
      t.string :type
      t.references :src, :polymorphic => true
      t.references :target, :polymorphic => true
      #predicate:  'source' is a 'type' of 'target'.
    end

  end
end



class User < ActiveRecord::Base
  has_many :relationships, :as => :target
  has_many :groups, :through => :relationships, :source => :src, :source_type => 'Group'
  attr_accessible :name
end

class Group < ActiveRecord::Base
  has_many :relationships, :as => :src
  has_many :users, :source => :target, :through => :relationships, :source_type => 'User'

  attr_accessible :name
end

class  Relationship < ActiveRecord::Base
  belongs_to :src, :polymorphic => true
  belongs_to :target, :polymorphic => true
  
  attr_accessible :type, :src_type, :src_id, :target_type, :target_id
end




begin
  Migration.migrate :up

  N = 3
  N.times {|i|
    g = Group.create(:name => "group#{i}")
    u = User.create(:name => "user#{i}")
  }

  N.times {|i|
    u = User.find(Random.rand(N)+1)
    g = Group.find(Random.rand(N)+1)
    u.groups << g
    u.save
  }
  
  u = User.find(1)
  g = Group.find(1)

  pp User.all
  pp Group.all

rescue => ex
  puts ex
ensure
#  Migration.migrate :down
end

