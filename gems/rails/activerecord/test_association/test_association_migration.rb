
gem 'activerecord', '~>3.2.13'
require 'active_record'

ActiveRecord::Base.establish_connection("mysql2://roadt:pass@venus/test")

class InitSchema < ActiveRecord::Migration
  def up
    say_with_time "Create tables ..." do 
      create_table :users do |t|
        t.primary_key :id
        t.string :name
      end

      create_table :groups do |t|
        t.primary_key :id
        t.string :name
      end

      # user group relationship table
      create_table :groups_users do |t|
        t.primary_key :id
        t.integer :user_id
        t.integer :group_id
      end
      
      # userinfo
      create_table :user_infos do |t|
        t.primary_key :id
        t.string :name
        t.string :value
      end

      create_table :forums do |t|
        t.primary_key :id
        t.string :name
      end

      create_table :posts do |t|
        t.primary_key :id
        t.string :name
        t.text :content
      end
    end
  end


  def prepare_seed_date 

  end

  def down
    [:users, :groups, :groups_users, :user_infos, :forums, :posts].each {|t| drop_table t}
  end
end


class SeedData < ActiveRecord::Migration
  def up
    
  end

  def down
  end
end

InitSchema.migrate(:up)


