


require 'active_support/time'

Time.zone = 'Eastern Time (US & Canada)'
Time.zone.local(2007, 2, 10, 15, 30, 45)
Time.zone.parse('2007-02-10 15:30:45')
Time.zone.at(1170361845)
Time.zone.now
Time.utc(2007, 2, 10, 20, 30, 45).in_time_zone



