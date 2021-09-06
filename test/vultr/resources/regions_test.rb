# frozen_string_literal: true

require "test_helper"

class RegionsResourceTest < Minitest::Test
  def test_list
    stub = stub_request("regions", response: stub_response(fixture: "regions/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    regions = client.regions.list

    assert_equal Vultr::Collection, regions.class
    assert_equal Vultr::Region, regions.data.first.class
    assert_equal 1, regions.total
  end

  def test_list_availability
    region_id = "all"
    stub = stub_request("regions/#{region_id}/availability", response: stub_response(fixture: "regions/list_availability"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    availabilities = client.regions.list_availability(region_id: region_id)

    assert_equal Vultr::Object, availabilities.class
    assert_equal availabilities.available_plans.first, "vc2-1c-1gb"
    assert_equal availabilities.available_plans.size, 20
  end
end
