

require 'securerandom'

R = SecureRandom

# random string
p R.hex(10)
p R.hex(10)
p R.hex(13)


# random base64 string
p R.base64(10)
p R.base64(10)
p R.base64(12)

#  random byte string
p R.random_bytes(10)
p R.random_bytes(10)

# 
p R.uuid
p R.uuid
