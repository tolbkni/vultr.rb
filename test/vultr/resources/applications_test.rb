# frozen_string_literal: true

require "test_helper"

class ApplicationsResourceTest < Minitest::Test
  def test_list
    stub = stub_request("applications", response: stub_response(fixture: "applications/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    applications = client.applications.list

    assert_equal Vultr::Collection, applications.class
    assert_equal Vultr::Application, applications.data.first.class
    assert_equal 2, applications.total
  end
end
