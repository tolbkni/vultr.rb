require 'test/test_helper'

class VultrPlanTest < Minitest::Test

  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_plan_list_url
    plan_list_url = 'https://api.vultr.com/v1/plans/list'
    assert_equal plan_list_url, Vultr::Plan._list
  end

  def test_plan_list_response
    r = Vultr::Plan.list

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Hash, r[:result]
  end

  def teardown
    # Do nothing
  end
end
