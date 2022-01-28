gem 'activesupport', '3.2.13'
require 'active_support/callbacks'
require 'awesome_print'


class Error2 < StandardError
end

class A
  include ActiveSupport::Rescuable

  rescue_from StandardError, with: :error_handler 

  def error_handler e
    ap e
    raise e
  end

  def run(case_no)
    ##....tic tik    
    case case_no
        when 1
          raise StandardError.new
        when 2
          raise Error2.new
    end
  rescue => exception
    rescue_with_handler(exception) || raise(exception)
  end
end


a = A.new
a.run 1
a.run 2
a.run 3
