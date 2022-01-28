
r = '~>3.2.13'
gem 'actionpack', r
gem 'actionview', r
require 'action_view'

class View < ActionView::Base
end


v = View.new
v.label_tag 'xxxx'



#csrf_helper
class View
  def protect_against_forgery?; false end
end
v.csrf_meta_tag  # nil
class View
  def protect_against_forgery?; true end
  def request_forgery_protection_token; __method__ end
  def form_authenticity_token(*args); __method__ end
end
v.csrf_meta_tag 
v.csrf_meta_tags

#asset_tag helper
v.auto_discovery_link_tag(:rss, 'url_options')
class View
  def url_for(options)
    options.to_a.join('-')
  end
end
v.auto_discovery_link_tag(:rss, {a:1,b:2}, {title: 'xxx',rel: 'relxxx' })
v.auto_discovery_link_tag(:rss, {a:1, b:2}, {title: 'xxx',rel: 'relxxx', type: 'typeyyy'})


#v.config.assets_dir="myassetsdir/"
v.config.asset_path = "myassetspath%s"
v.favicon_link_tag
v.image_path('xxxx.jpg')
v.video_path('aaa.mp4')
v.audio_path '444.mp3'
v.font_path 'xxx.ttf'
v.image_tag('xxxx', a:1, b:2)
v.image_alt('xxx')
v.video_tag('ddd.mp4', c:2, d:4)

#date_helper
require 'active_support/all'
from_time = Time.now
v.distance_of_time_in_words(from_time, from_time + 50.minutes)        # => about 1 hour
v.distance_of_time_in_words(from_time, 50.minutes.from_now)           # => about 1 hour
v.distance_of_time_in_words(from_time, from_time + 15.seconds)        # => less than a minute
v.distance_of_time_in_words(from_time, from_time + 15.seconds, true)  # => less than 20 seconds
v.distance_of_time_in_words(from_time, 3.years.from_now)              # => about 3 years
v.distance_of_time_in_words(from_time, from_time + 60.hours)          # => 3 days
v.distance_of_time_in_words(from_time, from_time + 45.seconds, true)  # => less than a minute
v.distance_of_time_in_words(from_time, from_time - 45.seconds, true)  # => less than a minute
v.distance_of_time_in_words(from_time, 76.seconds.from_now)           # => 1 minute
v.distance_of_time_in_words(from_time, from_time + 1.year + 3.days)   # => about 1 year
v.distance_of_time_in_words(from_time, from_time + 3.years + 6.months) # => over 3 years
v.distance_of_time_in_words(from_time, from_time + 4.years + 9.days + 30.minutes + 5.seconds) # => about 4 years
to_time = Time.now + 6.years + 19.days
v.distance_of_time_in_words(from_time, to_time, true)     # => about 6 years
v.distance_of_time_in_words(to_time, from_time, true)     # => about 6 years
v.distance_of_time_in_words(Time.now, Time.now)           # => less than a minute


I18n.load_path +=  Dir[File.join(File.dirname( __FILE__), 'locale', '*.yml')]
I18n.reload!

I18n.locale  = :en
I18n.t 'datetime.distance_in_words.about_x_hours'
I18n.t 'datetime.distance_in_words.about_x_hours', locale: 'zh-TW'
v.distance_of_time_in_words(from_time, from_time + 50.minutes, locale: 'zh-TW')


v.time_ago_in_words(Time.now - 60.minutes, locale: 'zh-TW')
v.time_ago_in_words(Time.now - 75.minutes)
v.distance_of_time_in_words_to_now(Time.now - 75.minutes)

v.date_select('typename', 'written_on')
v.time_select('typename', 'time')
v.datetime_select('typename', 'datetime')
v.select_datetime


now = Time.now
v.select_time now
v.select_second now
v.select_minute now
v.select_hour now

td = Date.today
v.select_day td
v.select_month td
v.select_year td

v.time_tag(Time.now)
v.time_tag(Date.today)


# tag_helper
v.tag 'div',  a:1, b:2
v.tag 'div', options={a:1,b:"<>"}, open=true
v.tag 'div', options={a:1,b:"<>"}, escape=false
v.send :tag_options, {a:1,b:"<>"}
v.send :tag_options, {a:1,b:"<>"}, false

v.content_tag('tag', 'content', a:1, b:2)
v.content_tag 'tag2',  a:1, b:2 do 
  v.label_tag 'xxx'
end

v.cdata_section "content"
v.escape_once("<asdf () []>")

# form_helper

gem 'activemodel'
require 'active_model'
class M 
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?; false end
  attr_accessor :a, :b
end

v.form_for M.new, url: 'xxx'  do |f|
  f.label 'xxx'
  f.select :a, ['choice1', 'choice2']
end


# form_options_helper

# form_tag_helper

# javascript_helper
v.escape_javascript("var i = 0; s = 'xxx';s2 =\"xxx\";for (var i in arguments) {alert(arguments[i])}")
v.j("a= 'a'")
v.javascript_tag("alert('all is good')")
v.javascript_tag("alert('all is good')", :defer=>'defer')
v.javascript_cdata_section('allxxxxx')

v.link_to_function "Greeting", "alert('Hello, world!')", :class=>"nav_link
"
# number_helper

# output_safety_helper

# record_tag_helper

# rendering_helper

# sanitize_helper

# tag_helper

# text_helper

# translation_helper

# url_helper

