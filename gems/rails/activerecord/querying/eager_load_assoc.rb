
gem 'activerecord', '~>3.2'
require 'active_record'
require 'pp'

ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "querying.sqlite"
)

class Migration < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.primary_key :id
      t.string :name
    end

    create_table :address do |t|
      t.primary_key :id
      t.string :name
      t.string :type
      t.references :client
    end

  end
end

begin
  Migration.migrate :up

print Client.all
print Address.all

ensure
  Migration.migrate :down
end


