# frozen_string_literal: true

require "test_helper"

class DnsResourceTest < Minitest::Test
  def test_list
    stub = stub_request("domains", response: stub_response(fixture: "domains/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    dns = client.dns.list

    assert_equal Vultr::Collection, dns.class
    assert_equal Vultr::Domain, dns.data.first.class
    assert_equal 1, dns.total
    assert_equal "next", dns.next_cursor
    assert_equal "prev", dns.prev_cursor
  end

  def test_create
    body = {domain: "example.com", ip: "192.0.2.123", dns_sec: :enabled}
    stub = stub_request("domains", method: :post, body: body, response: stub_response(fixture: "domains/create", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    dns = client.dns.create(**body)

    assert_equal "example.com", dns.domain
    assert_equal "2020-10-10T01:56:20+00:00", dns.date_created
  end

  def test_retrieve
    dns_domain = "example.com"
    stub = stub_request("domains/#{dns_domain}", response: stub_response(fixture: "domains/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    dns = client.dns.retrieve(dns_domain: dns_domain)

    assert_equal "example.com", dns.domain
    assert_equal "2020-10-10T01:56:20+00:00", dns.date_created
  end

  def test_update
    dns_domain = "example.com"
    body = {dns_sec: "enabled"}
    stub = stub_request("domains/#{dns_domain}", method: :put, body: body, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.dns.update(dns_domain: dns_domain, **body)
  end

  def test_delete
    dns_domain = "example.com"
    stub = stub_request("domains/#{dns_domain}", method: :delete, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.dns.delete(dns_domain: dns_domain)
  end

  def test_soa
    dns_domain = "example.com"
    stub = stub_request("domains/#{dns_domain}/soa", response: stub_response(fixture: "domains/soa"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    soa = client.dns.soa(dns_domain: dns_domain)

    assert_equal "ns1.vultr.com", soa.nsprimary
    assert_equal "admin@example.com", soa.email
  end

  def test_update_soa
    dns_domain = "example.com"
    body = {nsprimary: "ns1.vultr.com", email: "admin@example.com"}
    stub = stub_request("domains/#{dns_domain}/soa", method: :patch, body: body, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.dns.update_soa(dns_domain: dns_domain, **body)
  end

  def test_dnssec
    dns_domain = "example.com"
    stub = stub_request("domains/#{dns_domain}/dnssec", response: stub_response(fixture: "domains/dnssec"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.dns.dnssec(dns_domain: dns_domain)
  end

  def test_list_records
    dns_domain = "example.com"
    stub = stub_request("domains/#{dns_domain}/records", response: stub_response(fixture: "domains/records"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    dns = client.dns.list_records(dns_domain: dns_domain)

    assert_equal Vultr::Collection, dns.class
    assert_equal Vultr::Object, dns.data.first.class
  end

  def test_create_record
    dns_domain = "example.com"
    body = {name: "www", type: "A", data: "192.0.2.123", ttl: 300, priority: 0}
    stub = stub_request("domains/#{dns_domain}/records", method: :post, body: body, response: stub_response(fixture: "domains/record", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    dns = client.dns.create_record(dns_domain: dns_domain, **body)

    assert dns.id
    assert "www", dns.name
    assert "A", dns.type
    assert "192.0.2.123", dns.data
    assert 300, dns.ttl
    assert 0, dns.priority
  end

  def test_retrieve_record
    dns_domain = "example.com"
    record_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("domains/#{dns_domain}/records/#{record_id}", response: stub_response(fixture: "domains/record"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    dns = client.dns.retrieve_record(dns_domain: dns_domain, record_id: record_id)

    assert_equal record_id, dns.id
  end

  def test_update_record
    dns_domain = "example.com"
    record_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {name: "CNAME", data: "foo.example.com", ttl: 300, priority: 0}
    stub = stub_request("domains/#{dns_domain}/records/#{record_id}", method: :patch, body: body, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.dns.update_record(dns_domain: dns_domain, record_id: record_id, **body)
  end

  def test_delete_record
    dns_domain = "example.com"
    record_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("domains/#{dns_domain}/records/#{record_id}", method: :delete, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.dns.delete_record(dns_domain: dns_domain, record_id: record_id)
  end
end
