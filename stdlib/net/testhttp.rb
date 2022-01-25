

require 'net/http'
require 'minitest/unit'
require 'minitest/autorun'


def fetch(uri_str, limit = 10)
  raise ArgumentError, 'too many HTTP redirects' if limit == 0
  resp = Net::HTTP.get_response(URI(uri_str))

  case resp
    when Net::HTTPSuccess then
    resp
    when Net::HTTPRedirection then
    location = resp['location']
    warn "redirected to #{location}"
    fetch(location, limit - 1)
  else
    resp.value
  end
end


class TestHttp < MiniTest::Unit::TestCase

  def test_simple_get 
    uri = URI('http://oldman/blog')

    puts Net::HTTP.get(uri)

    params = {:limit => 10, :page => 3}
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    puts res.body if res.is_a?(Net::HTTPSuccess)
  end

  def test_fetch
    print    fetch('http://www.ruby-lang.org')
  end
end

