# frozen_string_literal: true

require "test_helper"

class StartupScriptsResourceTest < Minitest::Test
  def test_list
    stub = stub_request("startup-scripts", response: stub_response(fixture: "startup_scripts/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    startup_scripts = client.startup_scripts.list

    assert_equal Vultr::Collection, startup_scripts.class
    assert_equal Vultr::StartupScript, startup_scripts.data.first.class
    assert_equal 1, startup_scripts.total
  end

  def test_create
    body = {name: "Example Startup Script", type: "pxe", script: "QmFzZTY0IEV4YW1wbGUgRGF0YQ=="}
    stub = stub_request("startup-scripts", method: :post, body: body, response: stub_response(fixture: "startup_scripts/create", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    startup_script = client.startup_scripts.create(**body)

    assert_equal Vultr::StartupScript, startup_script.class
    assert_equal "Example Startup Script", startup_script.name
  end

  def test_restrieve
    startup_script_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("startup-scripts/#{startup_script_id}", response: stub_response(fixture: "startup_scripts/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    startup_script = client.startup_scripts.retrieve(startup_script_id: startup_script_id)

    assert_equal Vultr::StartupScript, startup_script.class
    assert_equal "Example Startup Script", startup_script.name
  end

  def test_update
    startup_script_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {name: "Changed"}
    stub = stub_request("startup-scripts/#{startup_script_id}", method: :patch, body: body, response: stub_response(fixture: "startup_scripts/update"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.startup_scripts.update(startup_script_id: startup_script_id, **body)
  end

  def test_delete
    startup_script_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("startup-scripts/#{startup_script_id}", method: :delete, response: stub_response(fixture: "startup_scripts/delete"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.startup_scripts.delete(startup_script_id: startup_script_id)
  end
end
