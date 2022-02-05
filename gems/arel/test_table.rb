

require 'active_record'

include Arel

ActiveRecord::Base.establish_connection  adapter: 'sqlite3', database: 'arel.sqlite3'

users = Table.new(:userss)
query = users.project(Arel.sql('*'))
query.to_sql

users.where(users[:name].eq('amy')).to_sql  #SELECT FROM \"userss\"  WHERE \"userss\".\"name\" = 'amy'
users.project(users[:id]).to_sql  #=> "SELECT \"userss\".\"id\" FROM \"userss\" " 


photos = Table.new(:photos)
users.join(photos).on(users[:id].eq(photos[:user_id])).to_sql # SELECT FROM \"userss\" INNER JOIN \"photos\" ON \"userss\".\"id\" = \"photos\".\"user_id\"


groups = Table.new(:groupss)
print users, groups

c1 = users.join(:groups).on(users[:gid].eq(groups[:id])).where(users[:name].eq('xxx').and(groups[:name].eq('xx%')))

puts c1.to_sql


c2 = users.where(users[:name].eq('xxx').and(groups[:name].eq('xx%'))).join(:groups).on(users[:gid].eq(groups[:id]))

puts c2.to_sql
puts  c1.to_sql == c2.to_sql


x = users.where(users[:name].eq('xxx').and(groups[:name].eq('xx%')))

puts x.to_sql
