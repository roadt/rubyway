
gem 'activesupport', '3.2.13'
require 'active_support/dependencies/autoload'


# native autoload
# mod.autoload(module, filename) -> nil
module M
  autoload :B, 'b'
end
M::B


class D
  extend ActiveSupport::Autoload
  
end
