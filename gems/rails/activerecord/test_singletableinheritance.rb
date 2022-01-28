

require 'active_record'
require 'pp'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "test.sqlite")

class  CreateTags < ActiveRecord::Migration

  def change
    create_table :tags do |t|
      t.string :name
      t.references :taggable, :polymorphic => true
      t.references :parent
      t.string :type
      t.timestamps
    end
  end
end



# Tag Model
class Tag < ActiveRecord::Base
  attr_accessible :name
  belongs_to  :taggable, :polymorphic => true
end


# Category model
# Single table inheritance
# has parent and childrens  attribute ( tag tables need `parent_id' column)
#
class Category < Tag
  belongs_to :parent, :class_name => "Category"
  has_many :childrens, :class_name => "Category", :foreign_key => "parent_id"
end

M = CreateTags
puts M.verbose = true
M.migrate :down
M.migrate :up

begin
  
  Tag.create(:name => 'linux')
  Tag.create(:name => 'c++')

   pp Tag.all

  c1 = Category.create(:name => 'languages')
  c2 = Category.create(:name => 'ruby')
  c2.parent = c1

  pp Category.all
  pp c1.childrens
ensure

end



