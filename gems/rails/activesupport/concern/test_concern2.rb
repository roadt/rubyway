
  require 'active_support/concern'

  module Foo
    extend ActiveSupport::Concern
"    included do
      class_eval do
        def self.method_injected_by_foo
          puts 'self.method_injected_by_foo'
        end
      end
    end
"
    module ClassMethods
      def method_injected_by_foo
        puts 'self.method_injected_by_foo'
      end
    end
  end

  module Bar
    extend ActiveSupport::Concern
    include Foo

    included do
      self.method_injected_by_foo
    end
  end

  class Host
    include Bar # works, Bar takes care now of its dependencies
  end


# conclusion,
# 1, module ClassMethods can be simulated with  included do + self.method_name.
