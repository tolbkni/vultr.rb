# frozen_string_literal: true

require "test_helper"

class PrivateNetworksResourceTest < Minitest::Test
  def test_list
    stub = stub_request("private-networks", response: stub_response(fixture: "private_networks/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    private_networks = client.private_networks.list

    assert_equal Vultr::Collection, private_networks.class
    assert_equal Vultr::PrivateNetwork, private_networks.data.first.class
    assert_equal 1, private_networks.total
  end

  def test_create
    body = {region: "ewr", description: "Example Private Network", v4_subnet: "10.99.0.0", v4_subnet_mask: 24}
    stub = stub_request("private-networks", method: :post, body: body, response: stub_response(fixture: "private_networks/create", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    private_network = client.private_networks.create(**body)

    assert_equal Vultr::PrivateNetwork, private_network.class
    assert_equal "Example Private Network", private_network.description
  end

  def test_retrieve
    private_network_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("private-networks/#{private_network_id}", response: stub_response(fixture: "private_networks/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    private_network = client.private_networks.retrieve(network_id: private_network_id)

    assert_equal Vultr::PrivateNetwork, private_network.class
    assert_equal "Example Network Description", private_network.description
  end

  def test_update
    private_network_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {description: "Example Private Network"}
    stub = stub_request("private-networks/#{private_network_id}", method: :put, body: body, response: stub_response(fixture: "private_networks/update"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.private_networks.update(network_id: private_network_id, **body)
  end

  def test_delete
    private_network_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("private-networks/#{private_network_id}", method: :delete, response: stub_response(fixture: "private_networks/delete"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.private_networks.delete(network_id: private_network_id)
  end
end
