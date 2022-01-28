
gem 'activemodel', '~> 3.2.13'
gem 'activesupport', '~> 3.2.13'
require 'active_support/core_ext'
require 'active_model'
require 'byebug'

######### attribute methods
#   AttributeMethods is used to generate bunch of methods for given attributes.
#
#   
class Person
  include ActiveModel::AttributeMethods
  
  attribute_method_affix  :prefix => 'reset_', :suffix => '_to_default!'
  attribute_method_suffix '_contrived?'
  attribute_method_prefix 'clear_'

  #debugger
  define_attribute_methods ['name']
  
  attr_accessor :name
  
  private
  
  def attribute_contrived?(attr)
    true
  end
  
  def clear_attribute(attr)
    send("#{attr}=", nil)
  end
  
  def reset_attribute_to_default!(attr)
    send("#{attr}=", "Default Name")
  end
end

p = Person.new 
p.name
p.name = 'tt'
p.name
p.clear_name
p.reset_name_to_default!
p.name
p.name_contrived?
p.methods 


############  callbacks
class Person
  extend ActiveModel::Callbacks
  define_model_callbacks :create

  
  def create
    run_callbacks :create do
      # your create action methods here
      puts "create here"
    end

    run_callbacks :create2 do
      puts "create2 here"
    end
  end


  before_create :action_before_create
  def action_before_create
    puts "before create"
  end

  after_create :action_after_create
  def action_after_create
    puts "after create"
  end

  around_create :action_around_create
  def action_around_create
    puts "action around create begin"
    yield   # then calll create and show "create here"
    puts "action around create end"
  end


  define_model_callbacks :create2, :only => [:before, :after]
  before_create2 :action_before_create
  after_create2 :action_after_create
  #  around_create2 :action_around_create   

end


p = Person.new
p.create


########### Tracking value changes
# diry 
class Person
  include ActiveModel::Dirty  # this include  ActiveModel::AttributeMethods

  define_attribute_methods  [:name]

  def name 
    @name
  end

  def name= value
    name_will_change! unless value == @name
    @name = value
  end

  def save
    @previously_changed = changes
    @changed_attributes.clear
  end
end

p = Person.new
p.name 
p.changed?
p.name = 'bob'
p.changed?
p.changes 
p.save
p.name = 'ok'
#p.save
p.changed?
p.changes
p.previous_changes



# skip this, it is placeholder for investigation from debugger
class C
  include ActiveModel::Dirty
  debugger
  define_attribute_methods [:name]

  def name
    @name
  end
  
  def name= value
    name_will_change! unless value == @name
    @name = value
  end
end





##### name instropection


class NamedPerson
  extend ActiveModel::Naming
end

NamedPerson.model_name
NamedPerson.model_name.human
NamedPerson.model_name.singular
NamedPerson.model_name.plural

NamedPerson.model_name.element
NamedPerson.model_name.collection

NamedPerson.model_name.partial_path
NamedPerson.model_name.singular_route_key
NamedPerson.model_name.route_key

NamedPerson.model_name.param_key
NamedPerson.model_name.i18n_key


#### Observing,   event observing out of model class


# include Observing in Model
class  C 
  include ActiveModel::Observing

  def create
    notify_observers(:before_create)
    puts "creating"
    notify_observers(:after_create)
  end
end

# create Observer 
class CObserver < ActiveModel::Observer

  def before_create obj
    puts 'CObserver::before_create'
  end

  def after_create obj
    puts 'CObserver::after_create'
  end

end

# assign Observer to Model, and instantiate in some startup
C.observers = :c_observer
C.observers
C.instantiate_observers

# create mdoel instance and do actions.
C.new.create




############ ActionMode::Serialization ##

class Person
  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml

  attr_accessor :name

  def attributes
    {"name" => name}
  end
end

p = Person.new
p.name="tom"
p.serializable_hash  # from ActiveModel::Serialization

p.as_json  
p.to_json

p.to_xml



##########  I18n support

class Person
  extend ActiveModel::Translation
end

Person.human_attribute_name('my_attribute')


#########  Validation support


class Person

  include ActiveModel::Validations

  attr_accessor :first_name, :last_name

  validates_each :first_name, :last_name do |rec, attr, value|
    rec.errors.add attr, 'starts with z.' if value.to_s[0] == ?z
  end
  
end

p = Person.new
p.first_name = 'zoolander'
p.valid?


# #validate
class Person
  include ActiveModel::Validations
  attr_accessor :commenter, :commentee

  validate :must_has_one_name
  def must_has_one_name
    errors.add(:base, 'Must be friends to leave a comment') if first_name.nil? and last_name.nil?
  end
  
  # the same
  validate do |person|
    person.must_has_one_name
  end

  # the same
  validate do 
    errors.add(:base, 'Must be friends to leave a comment') if first_name.nil? and last_name.nil?
  end
end

p = Person.new
p.valid? or p.errors
p.first_name = 'xxx'
p.valid?




# customer validators
class HasNameValidator < ActiveModel::Validator
  def validate(rec)
    rec.errors[:name] = "must exists" if rec.name.blank?
  end
end

class ValidatorPerson
  include ActiveModel::Validations
  validates_with HasNameValidator
  attr_accessor :name
end

p = ValidatorPerson.new
p.valid?
p.errors.full_messages
p.name = "Bob"
p.valid?


# custom  each validator  (EachValidator)
class  NotNullValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] = "must not nil" if value.nil?
  end
end

class  C
  include ActiveModel::Validations
  validates_with NotNullValidator, :attributes => [:first_name, :last_name]
  attr_accessor :first_name, :last_name
end

c = C.new
c.valid?
c.first_name = c.last_name = 'mm'
c.valid?


##
