#
# test all singleton class behaviors here
#
class C3
end

class C2 < C3
end

class C1 < C2
end

SC3 = C3.singleton_class
SC2 = C2.singleton_class
SC1 = C1.singleton_class


o3 = C3.new
S3 = o3.singleton_class

o2 = C2.new
S2 = o2.singleton_class

o1 = C1.new
S1 = o1.singleton_class


# ====   tests ======
class S1
  def s1f1; end;
end
S1.ancestors   #[#<Class:#<C1:0x0000563975c9e050>>, C1, C2, C3, Object, PP::ObjectMixin, Kernel, BasicObject]
o1.class
o1.s1f1  #ok

class S2
  def s2f1; end;
end
S2.ancestors   #[#<Class:#<C2:0x00005639766010c0>>, C2, C3, Object, PP::ObjectMixin, Kernel, BasicObject] 
o2.class
o2.s2f1  #ok
o1.s2f1  #no,   object singelton methods not inherited, only app for object itself.



## sc2 is ancestors of sc1? - yes

SC2.ancestors  #[#<Class:C2>, #<Class:C3>, #<Class:Object>, #<Class:BasicObject>, Class, Module, Object, PP::ObjectMixin, Kernel, BasicObject] 
class SC2
  def sc2f1; end
end
C2.sc2f1  #ok
C1.sc2f1  #ok -   class singleton methods are inhierted from parent class (acutally. parent singelton_class)


# C.extend
module M1
  def m1f1; end
end
SC1.ancestors #[#<Class:C1>, #<Class:C2>, #<Class:C3>, #<Class:Object>, #<Class:BasicObject>, Class, Module, Object, PP::ObjectMixin, Kernel, BasicObject] 
C1.extend M1
SC1.ancestors   #[#<Class:C1>, M1, #<Class:C2>, #<Class:C3>, #<Class:Object>, #<Class:BasicObject>, Class, Module, Object, PP::ObjectMixin, Kernel, BasicObject]

# C.include
C1.ancestors  #[C1, C2, C3, Object, PP::ObjectMixin, Kernel, BasicObject]
C1.include M1
C1.ancestors  #[C1, M1, C2, C3, Object, PP::ObjectMixin, Kernel, BasicObject]
