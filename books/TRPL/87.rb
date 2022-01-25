

# 8.7. ObjectSpace and GC

# The ObjectSpace module defines a handful of low-level methods that can be occasionally useful for debugging or metaprogramming. The most notable method is each_object, an iterator that can yield every object (or every instance of a specified class) that the interpreter knows about: 

#Print out a list of all know classes
ObjectSpace.each_object(Class) {|c| puts c}



# ObjectSpace._id2ref is the inverse of Object.object_id: it takes an object ID as its argument and returns the corresponding object, or raises a RangeError if there is no object with that ID. 

# ObjectSpace.define_finalizer allows the registration of a Proc or a block of code to be invoked when a specified object is garbage collected. You must be careful when registering such a finalizer, however, as the finalizer block is not allowed to use the garbage collected object. Any values required to finalize the object must be captured in the scope of the finalizer block, so that they are available without dereferencing the object. Use ObjectSpace.undefine_finalizer to delete all finalizer blocks registered for an object. 


# The final ObjectSpace method is ObjectSpace.garbage_collect, which forces Ruby's garbage collector to run. Garbage collection functionality is also available through the GC module. GC.start is a synonym for ObjectSpace.garbage_collect. Garbage collection can be temporarily disabled with GC.disable, and it can be enabled again with GC.enable. 

# The combination of the _id2ref and define_finalizer methods allows the definition of "weak reference" objects, which hold a reference to a value without preventing the value from being garbage collected if they become otherwise unreachable. See the WeakRef class in the standard library (in lib/weakref.rb) for an example. 

# weakref.rb
