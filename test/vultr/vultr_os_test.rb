require 'test/test_helper'

class VultrOsTest < Minitest::Test
  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_os_list_url
    os_list_url = 'https://api.vultr.com/v1/os/list'
    assert_equal os_list_url, Vultr::OS._list
  end

  def test_os_list_response
    r = Vultr::OS.list

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Hash, r[:result]
  end

  def teardown
    # Do nothing
  end
end
