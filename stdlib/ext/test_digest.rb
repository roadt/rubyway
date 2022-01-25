
require 'digest'


Digest.constants


D = Digest::MD5
r = D.digest 'message'
r = D.base64digest 'message'
r = D.hexdigest 'message'
r.length

D = Digest::SHA256
r = D.digest 'message'
r = D.base64digest 'message'
r = D.hexdigest 'message'
r.length
D.file 'message'

D = Digest::SHA384
r = D.digest 'message'
r = D.base64digest 'message'
r = D.hexdigest 'message'
r.length


D = Digest::SHA512
r = D.digest 'message'
r = D.base64digest 'message'
r = D.hexdigest 'message'
r.length

D = Digest::SHA1
r = D.digest 'message'
r = D.base64digest 'message'
r = D.hexdigest 'message'
r.length

D = Digest::SHA2
r = D.digest 'message'
r = D.base64digest 'message'
r = D.hexdigest 'message'
r.length
