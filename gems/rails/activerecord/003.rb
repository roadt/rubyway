

# try to connection wordpress database
require 'active_record'

ENV['DATABASE_URL'] = 'mysql2://roadt:pass@localhost/wp'

class WP_Link < ActiveRecord::Base
  establish_connection
end

puts WP_Link.all()



