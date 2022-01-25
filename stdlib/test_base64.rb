
require 'base64'

s = 'send reinforcements'
enc = Base64.encode64(s)
plain = Base64.decode64(enc)

enc = Base64.strict_encode64(s)
Base64.strict_decode64(enc)

enc = Base64.urlsafe_encode64(s)
Base64.urlsafe_decode64(s)
