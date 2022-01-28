
require 'active_record'
require 'pp'


ENV['DATABASE_URL'] = 'mysql2://roadt:pass@localhost/test'

class B < ActiveRecord::Base
  establish_connection
end

 B.find_all_by_id(128);



