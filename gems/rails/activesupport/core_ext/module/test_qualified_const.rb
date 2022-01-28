require 'active_support/core_ext/module/qualified_const'
require 'pp'


module M
  module M1
    module M2
    end
  end
end

puts M.qualified_const_get  "M1::M2"

puts M::M1::M2.qualified_const_defined? "M1"
