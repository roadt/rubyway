
gem 'activerecord', '~>3.2'
require 'active_record'
require 'pp'

ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "assocs.sqlite"
)

class Migration < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.primary_key :id
      t.string :name
      t.references :attachable, :polymorphic => true
    end

    create_table :posts do |t|
      t.primary_key :id
      t.string :name
      t.string :type
    end

  end
end


class Asset < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
end


class Post < ActiveRecord::Base
  has_many :assets,  :as => :attachable, :dependent => :destroy
end

class GuestPost < Post
end


begin
  Migration.migrate :up

  3.times {|i|
    p = Post.create(:name => "post#{i}")
    3.times { |j|
      u = Asset.create(:name => "asset #{i}-#{j}", :attachable => p)
    }
  }
  # 
  pp Post.all
  pp Asset.all

  p = Post.first
  pp p.assets
  pp Asset.first.attachable

  gp = GuestPost.new(:name => "gpost1")
  gp.assets  << Asset.new(:name => "asset01")
  gp.save

  
  pp gp
  pp gp.assets
  pp Asset.all
  gp.destroy
  pp Post.connection.select_all("select * from posts")
  pp Asset.all
ensure
  Migration.migrate :down
end


