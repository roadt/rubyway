

require 'tempfile'

file = Tempfile.new('foo')
file.path
file.write('hello, world')

file.rewind
file.read
file.close
file.unlink
