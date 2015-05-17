require 'test/test_helper'

class VultrRegionTest < Minitest::Test

  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_region_list_url
    region_list_url = 'https://api.vultr.com/v1/regions/list'
    assert_equal region_list_url, Vultr::Region._list
  end

  def test_region_availability_url
    region_list_url = 'https://api.vultr.com/v1/regions/availability?DCID=1'
    assert_equal region_list_url, Vultr::Region._availability(DCID: 1)
  end

  def test_region_responses
    r = Vultr::Region.list

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Hash, r[:result]

    k, v = r[:result].first
    dc_id = k.to_i

    r = Vultr::Region.availability(DCID: dc_id)

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Array, r[:result]
  end

  def teardown
    # Do nothing
  end
end