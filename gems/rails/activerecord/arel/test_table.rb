

require 'active_record'

include Arel

ActiveRecord::Base.establish_connection  adapter: 'sqlite3', database: 'arel.sqlite3'

user = Table.new(:users)
group = Table.new(:groups)

print user, group

c1 = user.join(:group).on(user[:gid].eq(group[:id])).where(user[:name].eq('xxx').and(group[:name].eq('xx%')))

puts c1.to_sql


c2 = user.where(user[:name].eq('xxx').and(group[:name].eq('xx%'))).join(:group).on(user[:gid].eq(group[:id]))

puts c2.to_sql
puts  c1.to_sql == c2.to_sql


x = user.where(user[:name].eq('xxx').and(group[:name].eq('xx%')))

puts x.to_sql
