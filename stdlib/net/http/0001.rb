


require 'net/http'

H = Net::HTTP
H.get('google.com', '/')

H.get_response(URI('http://pimg-fpiw.uspto.gov/fdd/47/060/082/0.pdf'))
