require 'net/http'

puts Net::HTTP.get('google.com', '/index.html')
