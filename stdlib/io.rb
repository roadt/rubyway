

File.open(__FILE__) do |f|
  f.each_byte {|c| print  "#{c.chr}:#{c}"}
end


File.open(__FILE__) do |f|
  f.each_line {|line| puts  "Got #{line.dump}"}
end


IO.foreach(__FILE__) {|line| puts  "Got #{line.dump}"}

str = IO.read(__FILE__)
str.length
str[0, 30]

arr = IO.readlines(__FILE__)
arr.length
arr[0]



