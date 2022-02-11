
gem 'apk_downloader'
require 'apk_downloader'

ApkDownloader.configure do |config|
  config.email = ENV['test.gmail.username']
  config.password = ENV['test.gmail.password']
  config.android_id = ENV['test.android_id']
end
