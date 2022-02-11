
gem 'awesome_print', '~> 1.0'
require 'awesome_print'

data = [ false, 42, %w(forty two), { :now => Time.now, :class => Time.now.class, :distance => 42e42 } ]
ap data

data = { :now => Time.now, :class => Time.now.class, :distance => 42e42 }
ap data, :indent => -2  # <-- Left align hash keys.


data = [ false, 42, %w(forty two) ]
data << data  # <-- Nested array.
ap data, :multiline => false


class Hello
  def self.world(x, y, z = nil, &blk)
  end
end
ap Hello.methods - Class.methods

ap (''.methods - Object.methods).grep(/!/)


ap 42 == ap(42)


some_array = (1..1000).to_a
ap some_array, :limit => true
