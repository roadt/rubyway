



# test method invocation determination process

# Guess1, invoke by name , no generic selection using paratmers
class C
  def f a,b
    print a,b
  end

  def f a
    print a
  end
end
# conclusion:
#   yes, select by method name
#   later def f will overwrite previous one



      

