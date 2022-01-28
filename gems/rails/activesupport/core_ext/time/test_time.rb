

gem 'activesupport', '2.3.18'

require 'active_support'
require 'active_support/core_ext'



Time.zone = 'Asia/Shanghai'
Time.zone.local(2014, 8, 4)
Time.zone.parse('2007-02-01 15:30:45')
Time.zone.at(1170361845)
Time.zone.now
Time.utc(1000).in_time_zone

t = Time.zone.now
t.hour
t.dst?
t.utc_offset
t.to_s(:rfc822)
t + 1.day
t.beginning_of_year
t > Time.utc(1999)

t.is_a?(Time)
t.is_a?(ActiveSupport::TimeWithZone)

