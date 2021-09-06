# frozen_string_literal: true

require "test_helper"

class ReservedIpsResourceTest < Minitest::Test
  def test_list
    stub = stub_request("reserved-ips", response: stub_response(fixture: "reserved_ips/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    reserved_ips = client.reserved_ips.list

    assert_equal Vultr::Collection, reserved_ips.class
    assert_equal Vultr::ReservedIp, reserved_ips.data.first.class
    assert_equal 2, reserved_ips.total
  end

  def test_create
    body = {region: "ewr", ip_type: "v4", label: "Example Reserved IPv4"}
    stub = stub_request("reserved-ips", method: :post, body: body, response: stub_response(fixture: "reserved_ips/create", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    reserved_ip = client.reserved_ips.create(**body)

    assert_equal Vultr::ReservedIp, reserved_ip.class
    assert_equal "Example Reserved IPv4", reserved_ip.label
  end

  def test_retrieve
    reserved_ip_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("reserved-ips/#{reserved_ip_id}", response: stub_response(fixture: "reserved_ips/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    reserved_ip = client.reserved_ips.retrieve(reserved_ip: reserved_ip_id)

    assert_equal Vultr::ReservedIp, reserved_ip.class
    assert_equal "Example Reserved IPv4", reserved_ip.label
  end

  def test_delete
    reserved_ip_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("reserved-ips/#{reserved_ip_id}", method: :delete, response: stub_response(fixture: "reserved_ips/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.reserved_ips.delete(reserved_ip: reserved_ip_id)
  end

  def test_attach
    reserved_ip_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {instance_id: "3f26dfe9-6a18-4f3d-a543-0cbca7a3e496"}
    stub = stub_request("reserved-ips/#{reserved_ip_id}/attach", method: :post, body: body, response: stub_response(fixture: "reserved_ips/attach"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.reserved_ips.attach(reserved_ip: reserved_ip_id, instance_id: body[:instance_id])
  end

  def test_detach
    reserved_ip_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("reserved-ips/#{reserved_ip_id}/detach", method: :post, response: stub_response(fixture: "reserved_ips/attach"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.reserved_ips.detach(reserved_ip: reserved_ip_id)
  end

  def test_convert
    body = {ip_address: "192.0.2.123", label: "Example Reserved IPv4"}
    stub = stub_request("reserved-ips/convert", method: :post, body: body, response: stub_response(fixture: "reserved_ips/convert", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    reserved_ip = client.reserved_ips.convert(**body)

    assert Vultr::ReservedIp, reserved_ip.class
    assert "Example Resreved IPv4", reserved_ip.label
  end
end
