gem 'activerecord', '~>4.2.7.1'
require 'active_record'
require 'pp'


ENV['DATABASE_URL'] = 'mysql2://roadt@localhost/test'

class B < ActiveRecord::Base
  establish_connection
end

B.where(id:128);

B.find_all_by_id(128).to_global_id


