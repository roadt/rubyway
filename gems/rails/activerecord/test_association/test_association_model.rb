

#  
#  define model and experiment
#
gem 'activerecord', '~>3.2'
require 'active_record'


ActiveRecord::Base.establish_connection("mysql2://roadt:pass@venus/test")

require 'logger'
ActiveRecord::Base.logger = Logger.new(STDOUT)

class User < ActiveRecord::Base
  has_one :userinfo, :class_name => "UserInfo"
  has_and_belongs_to_many :groups
  has_many :forums, :foreign_key => 'owner_id'
end

class UserInfo < ActiveRecord::Base
  attr_accessible :user_id, :name, :value
  belongs_to :user
end

class Group < ActiveRecord::Base
  has_many :user_groups
  has_and_belongs_to_many :users
end

class Forum < ActiveRecord::Base
  belongs_to :user, :foreign_key => 'owner_id'
end


class Relationship < ActiveRecord::Base

end


#
#
#


# create
User.transaction do
  u = User.create(:name=>"xx")
  ui = UserInfo.create(:user_id=>u.id, :name=>'p1', :value=>'v1')
end

# link model's association,  save model save association?  (yes) 
# has_one, has_many, belongs_to 
u = User.new(:name => 'yy')
u.userinfo = UserInfo.new(:name=>'p2', :value=>'v2')
u.save!

u = User.new(:name => 'zz')
u.groups << Group.new(:name=>'gg')
u.save!

