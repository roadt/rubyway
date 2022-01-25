

# Method Names

# 6.2.1 operator methods
def + (other)      # Define binary plus operator: x+y is x.+(y)
  self.concatenate(other)
end



# 6.2.2 Method Aliases

def hello
  puts "hello, world"
end

alias orginal_hello hello

def hello
  puts "your attention please"
  original_hello
  puts "this has been a test"
end

