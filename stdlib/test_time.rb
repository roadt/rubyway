


requre 'time'

Time.new
t = Time.now

Time.at t
Time.at 0
Time.at 0, 0

# Time.utc = Time.gm
#*    Time.utc(year, month, day, hour, min, sec, usec_with_frac) -> time
Time.utc 1990
Time.utc 1990, 2
Time.utc 1990, 2, 3
Time.utc 1990, 2, 3, 8
Time.utc 1990, 2, 3, 8, 30
Time.utc 1990, 2, 3, 8, 30, 40
Time.utc 1990, 2, 3, 8, 30, 40, 800


# *    Time.utc(sec, min, hour, day, month, year, wday, yday, isdst, tz) -> time
Time.utc 40, 30, 8, 3, 2, 1990,  1,2,3, true, 'CST'


#Time.local = Time.mktime
Time.local 1990
Time.local 1990, 2
Time.local 1990, 2, 3
Time.local 1990, 2, 3, 8
Time.local 1990, 2, 3, 8, 30
Time.local 1990, 2, 3, 8, 30, 40
Time.local 1990, 2, 3, 8, 30, 40, 800


t = Time.now
t.year
t.month
t.day
t.hour
t.min
t.sec

t.wday
t.mday
t.yday
t.isdst
t.dst?
t.zone
t.gmtoff
t.gmt_offset
t.utc_offset
t.utc?
t.gmt?

t.sunday?
t.monday?
t.tuesday?
t.wednesday?
t.thursday?
t.friday?
t.saturday?

t.tv_sec
t.tv_usec
t.usec
t.tv_nsec
t.nsec
t.subsec

t.strftime("%Y %m %d %H %M %S")


# + -  n seconds
t
t += 60   # 1min
t += 60*60 # 1hour
t += 60*60*24 #1 day

# succ , round
t.succ
t

(0..10).each do |n|
  puts t.round(n)
end


