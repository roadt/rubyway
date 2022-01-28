

gem 'globalid'
require 'globalid'

gid = Person.find(1).to_global_id

gid.uri
