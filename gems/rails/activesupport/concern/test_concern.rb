
gem 'activesupport', '3.2.13'
require 'active_support/all'

#  useful for include some class methods 
#  module has hierarchy.


module M1
  extend ActiveSupport::Concern
  included do 
    puts 'M1.included do ', self
  end

  def self.included base
    puts 'M1.included(base)', self, base
  end

  module ClassMethods
    def f
      puts 'M1.f'
    end
  end

  def m1
    puts "#m1"
  end
end

module M2
  extend ActiveSupport::Concern
  include M1
  
  included do 
    puts 'M2.included do', self
  end

  def self.included base
    puts 'M2.included(base)', self, base
  end

  module ClassMethods
    def g
      puts 'M2.g'
    end
  end

  def m2
    puts "#m2"
  end
end

class C
  include M2
end


C.f
C.g


"
--1
M1.included(base)
M1
M2


--2
M1.included do 
C

M1.included(base)
M1
C

M2.included do
C

M2.included(base)
M2
C

M1.f
M2.g
"


# conclusion
# 1, self.included(base) can coexist with  self.included do. put it after  self.include do. to prevent from overwriting 'self.included' method.

# 2, included do is called only once with C.  self.included(base) called twice, one is for M2, the other is for C.
# --1 is called when  M2 include M1.
# --2 are from  C include M2.  1st C include alll registered Concern module here (M1, M2). then call self.included. as Concern module are included in append_features(), prior than C.included(base).

# 3, Concern's included do  's self is always  final including Module. here is C.  and see --2. all base are C. this is what concern for..




o = Object.new
o.extend M2
o.methods
o.m1
o.m2
