

require 'rspec'
require 'rspec/expectations'

class Order
end

# basic
describe Order do
  it "sums the prices of the teism in tis line items" do
    i = 1 + 1
    expect(i).to eq(2)
  end

  it "equivalence" do
    expect(1).to eq(1)  # pass if actual == expected
    expect(1).to eql(1)  # pass if actual.eql?(expected)
  end

  it "identity" do
    expect(1).to be(1)  # pass if actual.equal?(expected)
    expect(1).to equal(1) # pass if actual.equal?(expected)
  end

  it "comparsions" do
    expect(2).to be > 1
    expect(2).to be >= 1
    expect(2).to be <= 3
    expect(2).to be < 4
    expect(2).to be_within(3).of(5)
  end

  it "regular expressions" do
    expect("3434").to match(/\d+/)
  end

  it "types/classes" do
    expect(1).to be_an_instance_of(Fixnum)
    expect(1).to be_a_kind_of(Fixnum)
  end

  it "truthiness" do
    expect(true).to be_true  # pass if actual is truthy (not nil or false)
    expect(false).to be_false  # pass if actual is falsy (nil or false)
    expect(nil).to be_nil   # pass if actaul is nil
  end

  it "expectnig errors" do
    expect {raise 1}.to raise_error
    expect { raise StandardError.new}.to raise_error(StandardError)
    expect { raise "message"}.to raise_error("message")
    expect {raise StandardError.new("message")}.to raise_error(StandardError, "message")
  end

  it "expecting throws" do
    expect { throw :a }.to throw_symbol
    expect { throw :aaa }.to throw_symbol(:aaa)
    expect { throw :aaa, 'bbb' }.to throw_symbol(:aaa, 'bbb')
  end

  it 'yielding' do
    expect { |b| 5.tap(&b) }.to yield_control # passes regardless of yielded args

#    expect { |b| yield if true }.to yield_with_no_args # passes only if no args are yielded

    expect { |b| 5.tap(&b) }.to yield_with_args(5)
    expect { |b| 5.tap(&b) }.to yield_with_args(Fixnum)
    expect { |b| "a string".tap(&b) }.to yield_with_args(/str/)

    expect { |b| [1, 2, 3].each(&b) }.to yield_successive_args(1, 2, 3)
    expect { |b| { :a => 1, :b => 2 }.each(&b) }.to yield_successive_args([:a, 1], [:b, 2])
  end

  it 'predicate' do
    ##expect(actual).to be_xxx  # passess if actual.xxx?
    expect(nil).to be_nil
    class C; def has_a?(i); true; end;end
    expect(C.new).to have_a(1)
  end

  it 'ranges' do
    expect(1..10).to cover(3)
  end

  it 'collection membership' do
    a = [1,2,3]
    expect(a).to include(2)
    expect(a).to start_with(1)
    expect(a).to end_with(3)

    expect([1,2,3]).to include(1)
    expect([1,2,3]).to include(1, 2)
    expect([1,2,3]).to start_with(1)
    expect([1,2,3]).to start_with(1,2)
    expect([1,2,3]).to end_with(3)
    expect([1,2,3]).to end_with(2,3)
    expect({:a => 'b'}).to include(:a => 'b')
    expect("this string").to include("is str")
    expect("this string").to start_with("this")
    expect("this string").to end_with("ring")
  end

  it 'should syntax' do
    1.should eq 1
    4.should be > 3
    [1,2,3].should_not include 4
  end
end


# run rspec
RSpec::Core::Runner.run(ARGV, $stderr, $stdout)
