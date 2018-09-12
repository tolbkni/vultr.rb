require 'test_helper'

class VultrPlanTest < Minitest::Test

  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_plan_list_response
    r = Vultr::Plans.list

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Hash, r[:result]
  end

  def teardown
    # Do nothing
  end
end
