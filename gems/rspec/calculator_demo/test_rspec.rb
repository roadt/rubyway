
$:.unshift File.expand_path('../', __FILE__)
require 'calculator'


describe Calculator do 
  describe "#add"  do
    it 'return the sum of its arguments' do
      expect(Calculator.new.add(1,2)).to eq(3)
      @a = 1
    end

    it 'test read naother instance varaible' do 
      print @a
    end
  end
end
