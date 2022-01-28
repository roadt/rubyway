# coding: utf-8


gem 'activesupport'
require 'active_support/all'
require 'pp'

I = ActiveSupport::Inflector
I.classify "forums"


pp I.inflections; nil
pp I.pluralize 'forum'
pp I.singularize 'forums'
pp I.camelize 'fourm_threads'
pp I.underscore 'ForumThread'
pp I.humanize 'fourm_threads'
pp I.titleize 'forum_threads
'
pp I.tableize 'ForumThread'
pp I.classify 'forum_threads'
pp I.dasherize 'forum_threads'

pp I.demodulize 'A::B::ForumThread'
pp I.deconstantize  'A::B::ForumThread'

pp I.foreign_key 'Message'
pp I.foreign_key 'Message', false

pp I.constantize 'String'
pp I.constantize 'string'

pp I.safe_constantize 'String'
pp I.safe_constantize 'string'

pp '1' + I.ordinal('1')
pp '2' + I.ordinal(2)
pp '3' + I.ordinal(3)
pp I.ordinalize(1)

pp I.transliterate('Ærøskøbing')
pp I.transliterate('ab我cde')

# Replaces special characters in a string so that it may be used as part of a 'pretty' URL.
#
# ==== Examples
#
#   class Person
#     def to_param
#       "#{id}-#{name.parameterize}"
#     end
#   end
#
#   @person = Person.find(1)
#   # => #<Person id: 1, name: "Donald E. Knuth">
#
#   <%= link_to(@person.name, person_path(@person)) %>
#   # => <a href="/person/1-donald-e-knuth">Donald E. Knuth</a>
pp I.parameterize('Forum_Thread')

