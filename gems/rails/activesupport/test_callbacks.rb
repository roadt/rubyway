
gem 'activesupport', '3.2.13'
require 'active_support/callbacks'
require 'awesome_print'

class Record
  include ActiveSupport::Callbacks
  define_callbacks :save

  def save
    run_callbacks :save do
      puts "- save"
    end
  end
end


class PersonRecord < Record
  set_callback :save, :before, :saving_message
  def saving_message
    puts "before saving..."
  end

  set_callback :save do
    puts 'before 2'
  end
  set_callback :save, :after do |object|
    puts "person - after save"
  end
  
  set_callback :save, :after, :f
  def f
    puts 'after-save - ffff'
  end

end

p = PersonRecord.new
p.save


####
class A
  include ActiveSupport::Callbacks

  define_callbacks :do

  set_callback :do , :before, :before_do
  set_callback :do, :after , :after_do
  set_callback :do, :around, :around_do

  def before_do
    puts 'before_do'
  end

  def before_do_a2
    puts 'before_do_a2'
  end
  set_callback :do , :before, :before_do_a2

  def after_do
    puts 'after_do'
  end

  def around_do
    puts 'around_do_start'
    yield
    puts 'around_do_end'
  end

  def do 
    run_callbacks :do do 
      puts '-do-'
    end
  end

end

class B <A
  set_callback :do , :before do 
    puts 'before_do b'
  end

  set_callback :do , :before do 
    puts 'before_do b2'
  end

end


a = A.new
a.do
'''
before_do
around_do_start
before_do_a2
-do-
around_do_end
after_do
'''

b = B.new
b.do

'''
before_do
around_do_start
before_do_a2
before_do b
before_do b2
-do-
around_do_end
after_do
'''


####### # options: 
#   :terminator  -  expression executed after every callback and if eval to true, halt callback process (following callbacks are not called)

class  C
  include ActiveSupport::Callbacks

  define_callbacks :run, :terminator => "result == false"

  def run
    run_callbacks :run do 
      puts "doing.."
    end
  end
  
end

class C1 < C
  set_callback :run, :before do
    puts 'before 1'
    false
  end

  set_callback :run, :before do 
    puts 'before 2'
  end
end

a = C1.new
a.run


## optoins  :rescable   
#  -   if false (default), callback raised exception halt following callback call.  
#  - if true, callback raised exception doesn't halt following callbacks

class C2 < C
  set_callback :run, :before do
    puts "before 1"
    raise 1
  end
  
  set_callback :run, :after do
    puts "after 2"
  end
  
end
c = C2.new
c.run

#
class D
  include ActiveSupport::Callbacks

  define_callbacks :run, :rescuable => true
  
  def run
    run_callbacks :run do
      puts "running..."
    end
  end

end

class D1 < D
  set_callback :run, :before do
    puts "before 1"
  end

  set_callback :run, :before do
    puts "before 2"
    raise StandardError.new
  end

  set_callback :run, :before do
    puts "before 3"
  end

  set_callback :run, :after do
    puts "after 1"
  end
  
end

d = D1.new
d.run



## :scope - when callback is a boject indicates which method is executed

class Audit
  def before(caller)
    puts "audit - before #{caller}"
  end

  def before_save(caller)
    puts "audio - before_save #{caller}"
  end

  def save(caller)
    puts "audit -save #{caller}"
  end
end

class Account
  include ActiveSupport::Callbacks

  define_callbacks :save
  set_callback :save, :before, Audit.new

  def save
    run_callbacks :save do
      puts 'save in main'
    end
  end
end

a = Account.new
a.save     # call Audit#before

#
class Account1 
  include ActiveSupport::Callbacks

  define_callbacks :save, :scope => [:kind, :name]   # kind is before/after, .name is 'callback name'
  set_callback :save, :before, Audit.new

  def save
    run_callbacks :save do
      puts 'save ...'
    end
  end
end
a = Account1.new
a.save     # call Audit#before_save   "#{kind}_#{name}"

# call Audio#save
#  define_callbacks :save, :scope => [:name]

class Account2
  include ActiveSupport::Callbacks

  define_callbacks :save, :scope =>  :name   # kind is before/after, .name is 'callback name'
  set_callback :save, :before, Audit.new

  def save
    run_callbacks :save do
      puts 'save ...'
    end
  end
end
a = Account2.new
a.save


# * <tt>:if</tt> - A symbol naming an instance method or a proc; the callback
#   will be called only when it returns a true value.
# * <tt>:unless</tt> - A symbol naming an instance method or a proc; the callback
#   will be called only when it returns a false value.
# * <tt>:prepend</tt> - If true, the callback will be prepended to the existing
#   chain rather than appended.
# * <tt>:per_key</tt> - A hash with <tt>:if</tt> and <tt>:unless</tt> options;
#   see "Per-key conditions" below
class  D
  include ActiveSupport::Callbacks

  define_callbacks  :run

  def run(name)
    run_callbacks :run, name do
      puts "running..."
    end
  end
end

class D1 < D

  set_callback :run, :before do
    puts "before run 1"
  end

  set_callback :run,  :before, :per_key => {:if => proc {|d| ap [d,self]; name == "index"}} do
    puts "before run 2"
  end

  set_callback :run, :after do
    puts "after run 1"
  end
  
end

d = D1.new
d.run 'aaa'
d.run 'index'
