


=begin
begin
  ...
rescue
 ..
ensure
...
end
=end



begin
  file = open("/tmp/some_file", "w");
  file.write('test')
  puts file.read
rescue
  puts "error #{$!}"
ensure
  file.close
end
