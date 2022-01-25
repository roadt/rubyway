# -*- coding: utf-8 -*-


#7.9. Constant Lookup.

# When a constant is referenced without any qualifying namespace, the Ruby interpreter must find the appropriate definition of the constant. To do so, it uses a name resolution algorithm, just as it does to find method definitions. However, constants are resolved much differently than methods. 

# Ruby first attempts to resolve a constant reference in the lexical scope of the reference. This means that it first checks the class or module that encloses the constant reference to see if that class or module defines the constant. If not, it checks the next enclosing class or module. This continues until there are no more enclosing classes or modules. Note that top-level or "global" constants are not considered part of the lexical scope and are not considered during this part of constant lookup. The class method Module.nesting returns the list of classes and modules that are searched in this step, in the order they are searched. 

# If no constant definition is found in the lexically enclosing scope, Ruby next tries to resolve the constant in the inheritance hierarchy by checking the ancestors of the class or module that referred to the constant. The ancestors method of the containing class or module returns the list of classes and modules searched in this step. 

# If no constant definition is found in the inheritance hierarchy, then top-level constant definitions are checked. 

# If no definition can be found for the desired constant, then the const_missing method—if there is one—of the containing class or module is called and given the opportunity to provide a value for the constant. This const_missing hook is covered in Chapter 8, and Example 8-3 illustrates its use. 

=begin

There are a few points about this constant lookup algorithm that are worth noting in more detail: 

>  Constants defined in enclosing modules are found in preference to constants defined in included modules.

> The modules included by a class are searched before the superclass of the class.

> The Object class is part of the inheritance hierarchy of all classes. Top-level constants, defined outside of any class or module, are like top-level methods: they are implicitly defined in Object. When a top-level constant is referenced from within a class, therefore, it is resolved during the search of the inheritance hierarchy. If the constant is referenced within a module definition, however, an explicit check of Object is needed after searching the ancestors of the module.

> The Kernel module is an ancestor of Object. This means that constants defined in Kernel behave like top-level constants but can be overridden by true top-level constants, that are defined in Object.


=end



# order:
#  lexical enclose scope ->  inhertance hierarchy or module  -> top-level cosntant definition.


module Kernel
  # defined in kernel
  A = B = C = D =E = F = " in kernel"
end

# top-level or "global" constatns defniied object
A = B = C =D =E = "top-level"

class Super 
  A = B =C =D = "in superclassd"
end

module Included
  A = B =C = "in included module"
end

module Enclosing
  A = B = "in eclosing module"

  class Local < Super 
    include Included
    
    A = "in local"

    print  [Module.nesting, self.ancestors, Object.ancestors], "\n"
    print search = (Module.nesting + self.ancestors + Object.ancestors).uniq, "\n"

    puts A,B,C,D,E,F
  end
end


