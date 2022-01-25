
gem 'minitest'
require 'minitest/autorun'
require 'singleton'


#--- class defintion ------
class Meme
  def i_can_has_cheezburger?
    "OHAI!"
  end

  def will_it_blend?
    "YES!"
  end
end

#-------- unit test -----------
class TestMeme < MiniTest::Test
  def setup
    @meme = Meme.new
  end

  def test_that_kitty_can_eat
    assert_equal "OHAI!", @meme.i_can_has_cheezburger?
  end

  def test_that_it_will_not_blend
    refute_match /^no/i, @meme.will_it_blend?
  end

  def test_that_will_be_skipped
    skip "test this later"
  end
end


#--- spec -----
describe Meme do 
  before do
    @meme = Meme.new
  end

  describe "when asked about cheeseburgers" do
    it "must respond positively" do 
      @meme.i_can_has_cheezburger?.must_equal "OHAI!"
    end
  end

  describe "when asked about blending possibilities" do
    it "won't say no" do
      @meme.will_it_blend?.wont_match /^no/i
    end
  end
end

#------------- benchmark --------------

require 'minitest/benchmark'
class TestMeBench < Minitest::Benchmark
  def bench_my_alog
    assert_performance_linear 0.9999 do |n|
      n = n*n*n*n*n
    end
  end
end

BENCH_SPEC_SUFFIX = "Benchmark"
describe "MemeSpec#{BENCH_SPEC_SUFFIX}"  do 
  bench_performance_constant "my_algor", 0.9999 do |n|
      n = n
  end
end




#---------- mocks ------------------------
"Mocks are pre-programmed with expectations which form a specification
of the calls they are expected to receive. They can throw an exception
if they receive a call they don't expect and are checked during
verification to ensure they got all the calls they were expecting."


class MemeAsker
  def initialize(meme)
    @meme = meme
  end

  def ask(question)
    method = question.tr(" ", "_") + "?"
    @meme.__send__(method)
  end
end

describe MemeAsker, :ask do 
  describe "when passed an unpunctuated question" do
    it "should invoke the appropiate predicate methdo on the meme" do
      @meme = Minitest::Mock.new
      @meme_asker = MemeAsker.new @meme
      @meme.expect :will_it_blend?, :return_value
      @meme_asker.ask "will it blend"
      @meme.verify
    end
  end
end


# stub
