require 'test_helper'

require 'stringutil'

class TestStringUtil < Minitest::Test
  
  def test_substitue_placeholders
    env = {
      :a => 1,
      :b => 2
    }
    r = StringUtil.substitute_placeholders(':a:xxx:b', env)
    assert_equal  r, '1:xxx2'

  end

end
