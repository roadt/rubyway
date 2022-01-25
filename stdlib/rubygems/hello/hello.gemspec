

Gem::Specification.new do |s|
  s.name = 'hello'
#  s.description = 'hello app for gemspec test and rubygems test'
  s.summary = 'hello app for gemspec and rubygems build test'
  s.version = '0.0.1'
  s.author = 'roadt'
#s.authors = []

# optional (warn)
#  s.description = 'hello app descrption'
#  s.homepage = 'http://oldman/'
#  s.email = 'roadtang@gmail.com'
  s.files = [ 'lib/hello.rb' ]


  s.signing_key = '/home/roadt/keys/privkey.pem'
  s.cert_chain = ['public.pem']
  
end
