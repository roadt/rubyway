

require 'active_record'
require 'pp'
require 'minitest/unit'


ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "assocs.sqlite")

class Migration < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.primary_key :id
      t.string :name
    end

    create_table :products do|t|
      t.primary_key :id
      t.string :name
      t.string :provider_id
      t.string :target_id
      t.string :ship_provider_id
    end

  end
end


class Company < ActiveRecord::Base
  has_many  :provided_products, :class_name=>Product, :foreign_key=> :provider_id
  has_many :got_products, :class_name=>Product, :foreign_key=>:target_id
  has_many :shipped_products, :class_name=>Product, :foreign_key =>:ship_provider_id
end

class Product < ActiveRecord::Base
  belongs_to :provider, :class_name=> Company
  belongs_to :target, :class_name=>Company
  belongs_to :ship_provider, :class_name=>Company
end



begin
  Migration.migrate :up

  10.times {|i|
    g = Company.create(:name => "company#{i}")
  }
  g1 = Company.first
  g = Company.last

  50.times {|j|
    u = Product.new(:name => "production#{j}")
    u.provider = g
    u.target =g1
    u.ship_provider = g
    u.save
  }

  puts Product.first.provider
  pp g.shipped_products
  pp g1.got_products
rescue => ex
  puts ex
ensure
  Migration.migrate :down
end


