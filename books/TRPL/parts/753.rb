

# Includable Namespace Modules

#It is possible to define modules that define a namespace but still allow their methods to be mixed in. The Math module works like this: 
Math.sin(0)    # => 0.0: Math is a namespace 
#include 'Math' # The Math namespace can be included
sin(0)         # => 0.0: Now we have easy access to the functions
