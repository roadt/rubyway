
require 'rspec'

h = {a:1, b:2}
 

#fetch
describe Hash do 
  describe "#fetch" do 
    before do 
      h = {a:1, b:2}
    end
    
    it "get value if key is found" do
      h.fetch(:a).should eq(1)
    end

    it "raise error if key is not found" do 
     expect { h.fetch(:c) }.to raise_error(KeyError)
    end

    it "return defautl value if key is not found" do
      h.fetch(:c, 3).should eq(3)
    end

    it "return block result if key is not found" do
      h.fetch(:c){|k| k.to_s*3}.should eq("ccc")
    end
  end
end

RSpec::Core::Runner.run(ARGV, $stderr, $stdout)
