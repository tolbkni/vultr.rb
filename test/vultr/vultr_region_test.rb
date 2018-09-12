require 'test_helper'

class VultrRegionTest < Minitest::Test

  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
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
