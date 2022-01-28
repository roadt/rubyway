#!/usr/bin/env ruby

require 'active_record'


# establish default connectoin
ActiveRecord::Base.establish_connection(
                                        :adapter => "mysql2",
                                        :host => "venus",
                                        :username => "roadt",
                                        :password => "pass",
                                        :database => "wp"
)




# some models

class WP_User < ActiveRecord::Base
  has_one :wp_usermeta
  has_many :wp_post
end

class WP_UserMeta < ActiveRecord::Base
  self.table_name = "wp_usermeta";

  belongs_to :wp_user
end

class WP_Post < ActiveRecord::Base
  belongs_to :wp_user
end


# redirect WP_Post and its subclass a new connection (which diff to defautl repo)
WP_Post.establish_connection(
                                        :adapter => "mysql2",
                                        :host => "localhost",
                                        :username => "roadt",
                                        :password => "pass",
                                        :database => "wp"
)





puts WP_User.first.wp_posts
