
gem 'activesupport', '3.2.13'
require 'active_support'

module Impl
  module Callbacks
    extend ActiveSupport::Concern
    
    def run_callbacks name, &blk
    end

    module ClassMethods
      def define_callback name
      end

      def set_callback name, type, &blk
      end
    end
  end
end


