
gem 'anemone'

require 'anemone'

Anemone.crawl('http://venus:81') do |an|
  an.on_every_page do |page|
    puts page.url
  end
end




