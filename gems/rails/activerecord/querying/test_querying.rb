gem 'activerecord', '3.2.13'
require 'active_record'
require 'pp'

ActiveRecord::Base. establish_connection(:adapter=>'sqlite3', :database => 'query.sqlite3')


class UserMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.primary_key :id
      t.string :name
      t.string :email
      t.string :sex
      
      t.timestamps
    end
  end
end

begin
  UserMigration.migrate :up


  class User < ActiveRecord::Base
    def to_s
      [id, name, email, sex].to_s
    end
  end

  10.times {
    User.create(:name=>"test");
  }

  pp User.find_by_sql("select * from users"); 
  pp User.count_by_sql("select count(0) from users"); 
  #print User.all()

ensure
  UserMigration.migrate :down;
end
