

require 'rspec'

module M
  describe 'M' do
    it "okok"
    it "nice nice"
  end
end

groups = RSpec.world.example_groups
puts groups

group = groups.first
puts group.description
puts group.examples

RSpec::Core::Runner.run(ARGV, $stderr, $stdout)
