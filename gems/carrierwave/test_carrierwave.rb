

require 'carrierwave'

class MyUploader < CarrierWave::Uploader::Base
  storage :file
end

u = MyUploader.new
#u.cache!(File.open(__FILE__))
u.store!(File.open(__FILE__))
u.retrieve_from_store!('test_carrierwave.rb')

#
u2 = MyUploader.new
u2.retrieve!('test_carrierwave.rb')
