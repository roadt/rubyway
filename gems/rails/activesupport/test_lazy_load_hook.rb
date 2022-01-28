
require 'awesome_print'
gem 'activesupport', '4.2.7.1'

require 'active_support'
require 'active_support/lazy_load_hook'


ActiveSupport.on_load(:a) {|o|  ap [self, o]}; nil


ActiveSupport.run_load_hooks(:a, 1)
ActiveSupport.run_load_hooks(:a, 2)

ActiveSupport.on_load(:a) {|o| puts "xxxx #{o}" }; nil
ActiveSupport.on_load(:a) {|o| puts "yyyy #{o}"}; nil

ActiveSupport.run_load_hooks(:a, 3); nil


# if yield, the binding/context object is main here.  
# if not yeidl, self is  loaded object
ActiveSupport.on_load(:a, yield:1) { |o| ap  [self, o]};nil
