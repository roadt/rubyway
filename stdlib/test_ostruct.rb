
require 'ostruct'
require 'json'
gem 'activesupport', '2.3.18'
require 'active_support/json'

australia = OpenStruct.new(:country => "Australia", :population => 20_000_000)
p australia

p australia.to_json
