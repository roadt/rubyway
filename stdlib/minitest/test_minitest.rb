
gem 'minitest'
require 'minitest/unit'
require 'singleton'


class TestCase1 < MiniTest::Unit::TestCase

  class << self  # test whether class level setup/teardown [A: No!]
    def setup
      puts 'class.setup'
    end
    def teardown
      puts 'class.teardown'
    end
  end

  def setup
    puts 'setup'
  end

  def teardown
    puts 'teardown'
  end

  def testa
    puts "a"
  end

  def test_b
    puts 'b'
  end
end


MiniTest::Unit.new.run ARGV
