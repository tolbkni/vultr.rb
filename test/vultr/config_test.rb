require "test_helper"

class ConfigTest < Minitest::Test
  def test_api_key
    assert_nil Vultr.api_key
    Vultr.api_key = "test"
    assert_equal "test", Vultr.api_key
  end
end
