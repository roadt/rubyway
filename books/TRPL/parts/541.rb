

1.upto(10) {|x| puts x}
1.upto(10) do |x|
  puts x
end

hash = { 1=>'a', 2=>'b' }
hash.each do |key, value|
  puts "#{key}: #{value}"
end


