

#file = open("some_file"); #in `open': No such file or directory - some_file


def first_line(filename)
  begin
    file = open(filename)
    info = file.read
    file.close
    info   # last thing evaluated is the return value
  rescue
    nil    # can't read the file? then don't return a string
  end
end


def first_line_v2(filename)
  begin
    file = open(filename)
    info = file.read
    file.close
    info   # last thing evaluated is the return value
  rescue
    filename = "STDIN"
    retry
  end
end

puts first_line('some_file')
puts first_line('/home/roadt/1.c')


#puts first_line_v2('testv2')


=begin
Every ruby library raises an exception if any error occurs, and you can raise exceptions explicitly in your code too. To raise an exception, use raise. It takes one argument, which should be a string that describes the exception. The argument is optional but should not be omitted. It can be accessed later via the special global variable $!.
=end

#raise "test error"
#file:41: test error (RuntimeError)

begin
  raise "test2"
rescue
  puts "an error occurred: #{$!}"
end
