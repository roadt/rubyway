gem 'activerecord', '3.2.13'
require 'active_record'
require 'pp'
require 'benchmark'

#ActiveRecord::Base. establish_connection(:adapter=>'sqlite3', :database => 'transaction.sqlite3')

ActiveRecord::Base. establish_connection(:adapter=>'postgresql', :database => 'hubworks_test', :host=> 'venus')


class NumberMigration < ActiveRecord::Migration
  def change
    create_table :numbers do |t|
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

puts  Benchmark.measure {
    Number.transaction {

      100000.times { |i|
        Number.create(i:i)
      }

    }
}

ensure
  NumberMigration.migrate :down;
end

