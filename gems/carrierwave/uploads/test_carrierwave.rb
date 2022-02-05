

require 'carrierwave'

class MyUploader < CarrierWave::Uploader::Base
  storage :file
end

u = MyUploader.new
u.cache!(File.open(__FILE__))
u.retrieve_from_store!('test_carrierwave.rb')
