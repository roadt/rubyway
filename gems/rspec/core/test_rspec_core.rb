

require 'rspec'

###### xxx  ##
class Order
  def sum a,b
    a + b
  end
end

describe Order do
  before :each do
    @a ||= 1
    @a += 1
  end

  it 'test' do
    t = double(:t)
    t.stub(:a) { 1}
    t.stub(:b){ 1}
    Order.new.sum(t.a,t.b).should eq @a
  end
end


## alias

describe "top level" do
  describe "2nd level" do
  end

  context "context is same as describe(in any level except top level)" do
  end
  
  describe "test" do
    it "asssert something" do
    end

    specify "assert another thing" do
    end

    example "assert other thing" do
    end
  end
end

## shared_examples and context
shared_examples "collections" do |collection_class|
  it "is empty when first created" do
    expect(collection_class.new).to be_empty
  end
end
describe Array do
  include_examples "collections", Array
end
describe Hash do
  include_examples "collections", Hash
end

### metadata
describe Order do
  it "check metadata" do
    expect(example.metadata[:description]).to eq("check metadata")
  end
end

## described_class
describe Order do
  it "use described_class to access described class obj" do
    expect(described_class).to equal(Order)
  end
end


RSpec::Core::Runner.run(ARGV, $stderr, $stdout)
