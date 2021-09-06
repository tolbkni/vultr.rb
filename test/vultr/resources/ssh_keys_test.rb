# frozen_string_literal: true

require "test_helper"

class SshKeysResourceTest < Minitest::Test
  def test_list
    stub = stub_request("ssh-keys", response: stub_response(fixture: "ssh_keys/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    ssh_keys = client.ssh_keys.list

    assert_equal Vultr::Collection, ssh_keys.class
    assert_equal Vultr::SshKey, ssh_keys.data.first.class
    assert_equal 1, ssh_keys.total
  end

  def test_create
    body = {name: "Example SSH Key", ssh_key: "ssh-rsa AA... user@example.com"}
    stub = stub_request("ssh-keys", method: :post, body: body, response: stub_response(fixture: "ssh_keys/create", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    ssh_key = client.ssh_keys.create(**body)

    assert_equal Vultr::SshKey, ssh_key.class
    assert_equal "Example SSH Key", ssh_key.name
  end

  def test_restrieve
    ssh_key_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("ssh-keys/#{ssh_key_id}", response: stub_response(fixture: "ssh_keys/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    ssh_key = client.ssh_keys.retrieve(ssh_key_id: ssh_key_id)

    assert_equal Vultr::SshKey, ssh_key.class
    assert_equal "Example SSH Key", ssh_key.name
  end

  def test_update
    ssh_key_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {name: "Changed"}
    stub = stub_request("ssh-keys/#{ssh_key_id}", method: :patch, body: body, response: stub_response(fixture: "ssh_keys/update"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.ssh_keys.update(ssh_key_id: ssh_key_id, **body)
  end

  def test_delete
    ssh_key_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("ssh-keys/#{ssh_key_id}", method: :delete, response: stub_response(fixture: "ssh_keys/delete"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.ssh_keys.delete(ssh_key_id: ssh_key_id)
  end
end
