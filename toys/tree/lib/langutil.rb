module LangUtil

  def self.included cls
    cls.extend ClassMethods
  end

  module ClassMethods
    def symbol_constant *syms
      syms.map do |sym|
        const_set sym.to_s.upcase, sym
      end
    end
  end
end
