


for i in 0..4
puts i
if (i == 2)
  retry
end
end


s = "hello, world!"
s.chars{|c|
puts c
}

for c in s
puts c
end
