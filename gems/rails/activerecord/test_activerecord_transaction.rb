gem 'activerecord', '3.2.13'
require 'active_record'
require 'pp'

ActiveRecord::Base. establish_connection(:adapter=>'sqlite3', :database => 'transaction.sqlite3')


class NumberMigration < ActiveRecord::Migration
  def change
    create_table :number do |t|
      t.primary_key :id
      t.integer :i, :uniqueness => true
      t.timestamps
    end
  end
end

begin
  NumberMigration.migrate :up


  class Number < ActiveRecord::Base
    def to_s
      i.to_s
    end
  end

  Number.transaction do
    Number.create(i:0)
    begin 
      Number.create(i:0)
    rescue ActiveRecord::StatementInvalid
      #..
    end
  end    
ensure
  NumberMigration.migrate :down;
end
