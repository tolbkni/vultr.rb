require 'test/test_helper'

class VultrAppTest < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_app_list_url
    app_list_url = 'https://api.vultr.com/v1/app/list'
    assert_equal app_list_url, Vultr::App._list
  end

  def test_app_list_response
    r = Vultr::App.list

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Hash, r[:result]
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end
end
