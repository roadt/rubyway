#!/usr/bin/env ruby
require 'optparse'

options = {}
opt = OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on('-v', '--[no-]verbose', 'Run everybody') do |v|
    options[:verbose] = v
  end

  opts.on('-n NAME', '--name', 'Given Name') do |v|
    options[:name] = v
  end

  opts.on('--delay N', Float, 'Delay time') do |n|
    options[:delay] = n
  end


  opts.on('-o', '--octal [OCTAL]', OptionParser::OctalInteger,
          "specify record spearator (default \\0") do |o|
    options[:octal] = o
  end

  opts.on('-l', '--list x,y,z', Array, "give list of values") do |list|
    options[:list] = list
  end
  
  opts.separator ""

  opts.on('t', '--type [TYPE]', [:text, :binary, :auto], "Select transfer type (text,binary, auto") do |t|
    options[:type] = t
  end
#  opts.on('-t', '--time [TIME]', Time, 'give time') do|time|
#    options.time = time
#  end
# unsupported argument type: Time (ArgumentError)

  opts.on_tail("-h", "--help", "show help message") do 
    puts opts
    exit
  end
end



opt.parse!(['-v', '--no-verbose', 
            '-nffg ', '',  
            '--delay=300.33',
            '-o333', 
            '-l1,2,3,4', '--list= 1,3,3,4',
           '-tbinary'])
print opt, options

#opt.parse!(['-v', '-h']);
#print options
