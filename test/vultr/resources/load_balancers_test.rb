# frozen_string_literal: true

require "test_helper"

class LoadBalancersResourceTest < Minitest::Test
  def test_list
    stub = stub_request("load-balancers", response: stub_response(fixture: "load_balancers/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    load_balancers = client.load_balancers.list

    assert_equal Vultr::Collection, load_balancers.class
    assert_equal Vultr::LoadBalancer, load_balancers.data.first.class
    assert_equal 1, load_balancers.total
  end

  def test_create
    body = {region: "ewr", balancing_algorithm: "roundrobin", label: "Example Load Balancer"}
    stub = stub_request("load-balancers", method: :post, body: body, response: stub_response(fixture: "load_balancers/create"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    load_balancer = client.load_balancers.create(**body)

    assert_equal Vultr::LoadBalancer, load_balancer.class
    assert_equal "Example Load Balancer", load_balancer.label
  end

  def test_retrieve
    load_balancer_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("load-balancers/#{load_balancer_id}", response: stub_response(fixture: "load_balancers/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    load_balancer = client.load_balancers.retrieve(load_balancer_id: load_balancer_id)

    assert_equal Vultr::LoadBalancer, load_balancer.class
    assert_equal "Example Load Balancer", load_balancer.label
  end

  def test_update
    load_balancer_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {balancing_algorithm: "Changed"}
    stub = stub_request("load-balancers/#{load_balancer_id}", method: :patch, body: body, response: stub_response(fixture: "load_balancers/update"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.load_balancers.update(load_balancer_id: load_balancer_id, **body)
  end

  def test_delete
    load_balancer_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("load-balancers/#{load_balancer_id}", method: :delete, response: stub_response(fixture: "load_balancers/delete"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.load_balancers.delete(load_balancer_id: load_balancer_id)
  end

  def test_list_forwarding_rules
    load_balancer_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("load-balancers/#{load_balancer_id}/forwarding-rules", response: stub_response(fixture: "load_balancers/list_forwarding_rules"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    forwarding_rules = client.load_balancers.list_forwarding_rules(load_balancer_id: load_balancer_id)

    assert Vultr::Collection, forwarding_rules.class
    assert Vultr::Object, forwarding_rules.data.first.class
    assert 1, forwarding_rules.total
  end

  def test_create_forwarding_rule
    load_balancer_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {frontend_protocol: "http", frontend_port: 8080, backend_protocol: "http", backend_port: 80}
    stub = stub_request("load-balancers/#{load_balancer_id}/forwarding-rules", method: :post, body: body, response: stub_response(fixture: "load_balancers/create_forwarding_rule"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.load_balancers.create_forwarding_rule(load_balancer_id: load_balancer_id, **body)
  end

  def test_retrieve_forwarding_rule
    load_balancer_id = "load-balancer-id"
    forwarding_rule_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("load-balancers/#{load_balancer_id}/forwarding-rules/#{forwarding_rule_id}", response: stub_response(fixture: "load_balancers/retrieve_forwarding_rule"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    forwarding_rule = client.load_balancers.retrieve_forwarding_rule(load_balancer_id: load_balancer_id, forwarding_rule_id: forwarding_rule_id)

    assert Vultr::Object, forwarding_rule.class
    assert "http", forwarding_rule.frontend_protocol
  end

  def test_delete_forwarding_rule
    load_balancer_id = "load-balancer-id"
    forwarding_rule_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("load-balancers/#{load_balancer_id}/forwarding-rules/#{forwarding_rule_id}", method: :delete, response: stub_response(fixture: "load_balancers/delete_forwarding_rule"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.load_balancers.delete_forwarding_rule(load_balancer_id: load_balancer_id, forwarding_rule_id: forwarding_rule_id)
  end

  def test_list_firewall_rules
    load_balancer_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("load-balancers/#{load_balancer_id}/firewall-rules", response: stub_response(fixture: "load_balancers/list_firewall_rules"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    firewall_rules = client.load_balancers.list_firewall_rules(load_balancer_id: load_balancer_id)

    assert Vultr::Collection, firewall_rules.class
    assert Vultr::Object, firewall_rules.data.first.class
    assert 1, firewall_rules.total
  end

  def test_retrieve_firewall_rule
    load_balancer_id = "load-balancer-id"
    firewall_rule_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("load-balancers/#{load_balancer_id}/firewall-rules/#{firewall_rule_id}", response: stub_response(fixture: "load_balancers/retrieve_firewall_rule"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    firewall_rule = client.load_balancers.retrieve_firewall_rule(load_balancer_id: load_balancer_id, firewall_rule_id: firewall_rule_id)

    assert Vultr::Object, firewall_rule
    assert 80, firewall_rule.port
  end
end
