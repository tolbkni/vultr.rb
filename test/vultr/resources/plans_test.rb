# frozen_string_literal: true

require "test_helper"

class PlansResourceTest < Minitest::Test
  def test_list
    stub = stub_request("plans", response: stub_response(fixture: "plans/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    plans = client.plans.list

    assert_equal Vultr::Collection, plans.class
    assert_equal Vultr::Plan, plans.data.first.class
    assert_equal 1, plans.total
  end

  def test_list_metal
    stub = stub_request("plans-metal", response: stub_response(fixture: "plans/list_metal"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    plans = client.plans.list_metal

    assert_equal Vultr::Collection, plans.class
    assert_equal Vultr::Plan, plans.data.first.class
    assert_equal 1, plans.total
  end
end
