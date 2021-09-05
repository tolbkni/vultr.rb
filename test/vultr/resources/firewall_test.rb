# frozen_string_literal: true

require "test_helper"

class FirewallResourceTest < Minitest::Test
  def test_list
    stub = stub_request("firewalls", response: stub_response(fixture: "firewall/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    firewall_group = client.firewall.list

    assert_equal Vultr::Collection, firewall_group.class
    assert_equal Vultr::FirewallGroup, firewall_group.data.first.class
    assert_equal 1, firewall_group.total
  end

  def test_create
    body = {description: "Example Firewall Group"}
    stub = stub_request("firewalls", method: :post, body: body, response: stub_response(fixture: "firewall/create"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    firewall_group = client.firewall.create(**body)

    assert_equal Vultr::FirewallGroup, firewall_group.class
    assert_equal "Example Firewall Group", firewall_group.description
  end

  def test_retrieve
    id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("firewalls/#{id}", response: stub_response(fixture: "firewall/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    firewall_group = client.firewall.retrieve(firewall_group_id: id)

    assert_equal Vultr::FirewallGroup, firewall_group.class
    assert_equal "Example Firewall Group", firewall_group.description
  end

  def test_update
    id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {description: "Example Firewall Group"}
    stub = stub_request("firewalls/#{id}", method: :put, body: body, response: stub_response(fixture: "firewall/update"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.firewall.update(firewall_group_id: id, **body)
  end

  def test_delete
    id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("firewalls/#{id}", method: :delete, response: stub_response(fixture: "firewall/delete"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.firewall.delete(firewall_group_id: id)
  end

  def test_list_rules
    id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("firewalls/#{id}/rules", response: stub_response(fixture: "firewall/list_rules"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    rules = client.firewall.list_rules(firewall_group_id: id)

    assert Vultr::Collection, rules.class
    assert Vultr::Object, rules.data.first.class
    assert 1, rules.total
  end

  def test_create_rule
    id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {ip_type: "v4", protocol: "tcp", subnet: "192.0.2.0", subnet_size: 24}
    stub = stub_request("firewalls/#{id}/rules", method: :post, body: body, response: stub_response(fixture: "firewall/create_rule"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.firewall.create_rule(firewall_group_id: id, **body)
  end

  def test_retrieve_rule
    firewall_id = "id"
    rule_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("firewalls/#{firewall_id}/rules/#{rule_id}", response: stub_response(fixture: "firewall/retrieve_rule"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    rule = client.firewall.retrieve_rule(firewall_group_id: firewall_id, firewall_rule_id: rule_id)

    assert Vultr::Object, rule.class
    assert "tcp", rule.protocol
  end

  def test_delete_forwarding_rule
    firewall_id = "id"
    rule_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("firewalls/#{firewall_id}/rules/#{rule_id}", method: :delete, response: stub_response(fixture: "firewall/delete_rule"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.firewall.delete_rule(firewall_group_id: firewall_id, firewall_rule_id: rule_id)
  end
end
