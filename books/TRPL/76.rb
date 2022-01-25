# -*- coding: utf-8 -*-


#7.6. Loading and Requiring Modules

=begin

Ruby programs may be broken up into multiple files, and the most natural way to partition a program is to place each nontrivial class or module into a separate file. These separate files can then be reassembled into a single program (and, if well-designed, can be reused by other programs) using require or load. These are global functions defined in Kernel, but are used like language keywords. The same require method is also used for loading files from the standard library. 

load and require serve similar purposes, though require is much more commonly used than load. Both functions can load and execute a specified file of Ruby source code. If the file to load is specified with an absolute path, or is relative to ~ (the user's home directory), then that specific file is loaded. Usually, however, the file is specified as a relative path, and load and require search for it relative to the directories of Ruby's load path (details on the load path appear below). 


Despite these overall similarities, there are important differences between load and require: 

> In addition to loading source code, require can also load binary extensions to Ruby. Binary extensions are, of course, implementation-dependent, but in C-based implementations, they typically take the form of shared library files with extensions like .so or .dll.

> load expects a complete filename including an extension. require is usually passed a library name, with no extension, rather than a filename. In that case, it searches for a file that has the library name as its base name and an appropriate source or native library extension. If a directory contains both an .rb source file and a binary extension file, require will load the source file instead of the binary file.

> load can load the same file multiple times. require tries to prevent multiple loads of the same file. (require can be fooled, however, if you use two different, but equivalent, paths to the same library file. In Ruby 1.9, require expands relative paths to absolute paths, which makes it somewhat harder to fool.) require keeps track of the files that have been loaded by appending them to the global array $" (also known as $LOADED_FEATURES). load does not do this.

> load loads the specified file at the current $SAFE level. require loads the specified library with $SAFE set to 0, even if the code that called require has a higher value for that variable. See Section 10.5 for more on $SAFE and Ruby's security system. (Note that if $SAFE is set to a value higher than 0, require will refuse to load any file with a tainted filename or from a world-writable directory. In theory, therefore, it should be safe for require to load files with a reduced $SAFE level.)

The subsections that follow provide further details about the behavior of load and require. 

=end

# 7.6.1. The Load Path

# Ruby's load path is an array that you can access using either of the global variables $LOAD_PATH or $:. (The mnemonic for this global is that colons are used as path separator characters on Unix-like operating systems.) Each element of the array is the name of a directory that Ruby will search for files to load. Directories at the start of the array are searched before directories at the end of the array. The elements of $LOAD_PATH must be strings in Ruby 1.8, but in Ruby 1.9, they may be strings or any object that has a to_path method that returns a string. 

#  The default value of $LOAD_PATH depends on your implementation of Ruby, on the operating system it is running on, and even on where in your filesystem you installed it. Here is a typical value for Ruby 1.8, obtained with ruby -e 'puts $:': 

puts $LOAD_PATH,"\n"
puts $:, "\n"

puts $","\n"

=begin

/usr/lib/site_ruby/1.8
/usr/lib/site_ruby/1.8/i386-linux
/usr/lib/site_ruby
/usr/lib/ruby/1.8
/usr/lib/ruby/1.8/i386-linux
.
=end

puts $LOAD_PATH,"\n"

# The /usr/lib/ruby/1.8/ directory is where the Ruby standard library is installed. The /usr/lib/ruby/1.8/i386-linux/ directory holds Linux binary extensions for the standard library. The site_ruby directories in the path are for site-specific libraries that you have installed. Note that site-specific directories are searched first, which means that you can override the standard library with files installed here. The current working directory "." is at the end of the search path. This is the directory from which a user invokes your Ruby program; it is not the same as the directory in which your Ruby program is installed. 

=begin

In Ruby 1.9, the default load path is more complicated. Here is a typical value: 

/usr/local/lib/ruby/gems/1.9/gems/rake-0.7.3/lib
/usr/local/lib/ruby/gems/1.9/gems/rake-0.7.3/bin
/usr/local/lib/ruby/site_ruby/1.9
/usr/local/lib/ruby/site_ruby/1.9/i686-linux
/usr/local/lib/ruby/site_ruby
/usr/local/lib/ruby/vendor_ruby/1.9
/usr/local/lib/ruby/vendor_ruby/1.9/i686-linux
/usr/local/lib/ruby/vendor_ruby
/usr/local/lib/ruby/1.9
/usr/local/lib/ruby/1.9/i686-linux

One minor load path change in Ruby 1.9 is the inclusion of vendor_ruby directories that are searched after site_ruby and before the standard library. These are intended for customizations provided by operating system vendors. 

The more significant load path change in Ruby 1.9 is the inclusion of RubyGems installation directories. In the path shown here, the first two directories searched are for the rake package installed with the gem command of the RubyGems package management system. There is only one gem installed in this example, but if you have many gems on your system, your default load path may become quite long. (When running programs that do not use gems, you may get a minor speed boost by invoking Ruby with the --disable-gems command-line option, which prevents these directories from being added to the load path.) If more than one version of a gem is installed, the version with the highest version number is included in the default load path. Use the Kernel.gem method to alter this default. 
=end


=begin


RubyGems is built into Ruby 1.9: the gem command is distributed with Ruby and can be used to install new packages whose installation directories are automatically added to the default load path. In Ruby 1.8, RubyGems must be installed separately (though some distributions of Ruby 1.8 may automatically bundle it), and gem installation directories are never added to the load path. Instead, Ruby 1.8 programs require the rubygems module. Doing this replaces the default require method with a new version that knows where to look for installed gems. See Section 1.2.5 for more on RubyGems. 

You can add new directories to the start of Ruby's search path with the –I command-line option to the Ruby interpreter. Use multiple –I options to specify multiple directories, or use a single –I and separate multiple directories from each other with colons (or semicolons on Windows). 
Ruby programs can also modify their own load path by altering the contents of the $LOAD_PATH array. Here are some examples: 
# Remove the current directory from the load path
$:.pop if $:.last == '.'  


=end

puts $:.pop if $:.last == '.'

puts $PROGRAM_NAME

# Add the installation directory for the current program to 
# the beginning of the load path

$LOAD_PATH.unshift File.expand_path($PROGRAM_NAME)

puts $PROGRAM_NAME

# Add the value of an environment variable to the end of the path
$LOAD_PATH << ENV['MY_LIBRARY_DIRECTORY']

print $:.class

# Finally, keep in mind that you can bypass the load path entirely by passing absolute filenames (that begin with / or ~) to load or require. 

# 7.6.2. Executing Loaded Code

=begin

loadandrequireexecute the code in the specified file immediately. Calling these methods is not, however, equivalent to simply replacing the call to load or require with the code contained by the file.[*]

[*] To put this another way for C programmers: load and require are different from C's #include directive. Passing a file of loaded code to the global eval function is closer to including it directly in a file: eval(File.read(filename)). But even this is not the same, as eval does not set local variables.

Files loaded with load or require are executed in a new top-level scope that is different from the one in which load or require was invoked. The loaded file can see all global variables and constants that have been defined at the time it is loaded, but it does not have access to the local scope from which the load was initiated. The implications of this include the following: 

The local variables defined in the scope from which load or require is invoked are not visible to the loaded file.

> Any local variables created by the loaded file are discarded once the load is complete; they are never visible outside the file in which they are defined.

> At the start of the loaded file, the value of self is always the main object, just as it is when the Ruby interpreter starts running. That is, invoking load or require within a method invocation does not propagate the receiver object to the loaded file.

> The current module nesting is ignored within the loaded file. You cannot, for example, open a class and then load a file of method definitions. The file will be processed in a top-level scope, not inside any class or module.



7.6.2.1. Wrapped loads

The load method has an infrequently used feature that we did not describe earlier. If called with a second argument that is anything other than nil or false, then it "wraps" the specified file and loads it into an anonymous module. This means that the loaded file cannot affect the global namespace; any constants (including classes and modules) it defines are trapped within the anonymous module. You can use wrapped loads as a security precaution (or as a way to minimize bugs caused by namespace collisions). We'll see in Section 10.5 that when Ruby is running untrusted code in a "sandbox," that code is not allowed to call require and can use load only for wrapped loads. 

When a file is loaded into an anonymous module, it can still set global variables, and the variables it sets will be visible to the code that loaded it. Suppose you write a file util.rb that defines a Util module of useful utility methods. If you want those methods to be accessible even if your file is loaded wrapped, you might add the following line to the end of the file: 

$Util = Util   # Store a reference to this module in a global variable

Now, the code that loads util.rb into an anonymous namespace can access the utility functions through the global $Util instead of the constant Util. 
In Ruby 1.8, it is even possible to pass the anonymous module itself back to the loading code: 

if Module.nesting.size > 0       # If we're loaded into a wrapper module
  $wrapper = Module.nesting[0]   # Pass the module back to the loading code
end

See Section 8.1.1 for more on Module.nesting. 

7.6.3. Autoloading Modules

The autoload methods of Kernel and Module allow lazy loading of files on an as-needed basis. The global autoload function allows you to register the name of an undefined constant (typically a class or module name) and a name of the library that defines it. When that constant is first referenced, the named library is loaded using require. For example: 
# Require 'socket' if and when the TCPSocket is first used
autoload :TCPSocket, "socket"


The Module class defines its own version of autoload to work with constants nested within another module. 
Use autoload? or Module.autoload? to test whether a reference to a constant will cause a file to be loaded. This method expects a symbol argument. If a file will be loaded when the constant named by the symbol is referenced, then autoload? returns the name of the file. Otherwise (if no autoload was requested, or if the file has already been loaded), autoload? returns nil. 

=end




