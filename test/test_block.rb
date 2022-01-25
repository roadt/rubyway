

# Test block capture
def capture_to_local(var, &block)
  set_var = block.binding.eval("lambda {|x| #{var} = x}")
  set_var.call(defined?(::Rails) ? capture(&block) : yield )
  puts set_var
end

capture_to_local("d")



# pass block thru methods
def f1
  yield 1
end

def f2
  f1 
end
f2 {|x| x+x }  # => no yield given in f2

def f3 &block
  f1 &block
end
f3{|x| x+x }  # => 2
