


module  M

  def f(const_name)
    print const_name
  end

end

module A 
  extend M
  f :name
end




