

module StringUtil

  class << self
    
    # replace placeholders in string 
    def substitute_placeholders(text, context)
      text.gsub(/:\w+/) { |s|
        name = s[1..-1]
        context[name] || context[name.to_sym] || s
      }
    end

  end
end
