

requier 'bench_press'
extend BenchPress

base_string = ""
measure "string append" do
  base_string << "Hello World"
end

base_string = ""
base_string = ""
measure "string +=" do
  base_string += "Hello World"
end
