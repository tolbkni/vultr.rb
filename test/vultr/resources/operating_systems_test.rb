# frozen_string_literal: true

require "test_helper"

class OperatingSystemsResourceTest < Minitest::Test
  def test_list
    stub = stub_request("os", response: stub_response(fixture: "operating_systems/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    operating_systems = client.operating_systems.list

    assert_equal Vultr::Collection, operating_systems.class
    assert_equal Vultr::OperatingSystem, operating_systems.data.first.class
    assert_equal 1, operating_systems.total
  end
end
