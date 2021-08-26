# frozen_string_literal: true

require "test_helper"

class InstancesResourceTest < Minitest::Test
  def test_list
    stub = stub_request("instances", response: stub_response(fixture: "instances/list", status: 200))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instances = client.instances.list

    assert_equal Vultr::Collection, instances.class
    assert_equal Vultr::Instance, instances.data.first.class
    assert_equal 3, instances.total
  end

  def test_create
    body = {region: "ewr", plan: "vc2-6c-16gb", label: "Example Instance", os_id: 215, user_data: "QmFzZTY0IEV4YW1wbGUgRGF0YQ==", backups: "enabled"}
    stub = stub_request("instances", method: :post, body: body, response: stub_response(fixture: "instances/create", status: 202))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.create(**body)

    assert_equal Vultr::Instance, instance.class
    assert_equal "Example Instance", instance.label
  end

  def test_retrieve
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}", response: stub_response(fixture: "instances/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.retrieve(instance_id: instance_id)

    assert_equal Vultr::Instance, instance.class
    assert_equal "Example Instance", instance.label
  end

  def test_update
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {label: "Example Instance", tag: "Example Tag", plan: "vc2-24c-97gb"}
    stub = stub_request("instances/#{instance_id}", method: :patch, body: body, response: stub_response(fixture: "instances/update", status: 202))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.update(instance_id: instance_id, **body)
  end

  def test_delete
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}", method: :delete, response: stub_response(fixture: "instances/delete", status: 204))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.delete(instance_id: instance_id)
  end

  def test_start
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/start", method: :post, response: stub_response(fixture: "instances/start", status: 204))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.start(instance_id: instance_id)
  end

  def test_reboot
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/reboot", method: :post, response: stub_response(fixture: "instances/reboot", status: 204))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.reboot(instance_id: instance_id)
  end

  def test_reinstall
    body = {hostname: "Example Instance"}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/reinstall", method: :post, body: body, response: stub_response(fixture: "instances/reinstall", status: 204))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.reinstall(instance_id: instance_id, **body)

    assert_equal Vultr::Instance, instance.class
    assert_equal "Example Instance", instance.label
  end

  def test_restore
    body = {backup_id: "cb676a46-66fd-4dfb-b839-443f2e6c0b60"}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/restore", method: :post, body: body, response: stub_response(fixture: "instances/restore", status: 202))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.restore(instance_id: instance_id, **body)

    assert_equal Vultr::Object, instance.class
    assert_equal "backup_id", instance.restore_type
  end

  def test_halt
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/halt", method: :post, response: stub_response(fixture: "instances/halt", status: 204))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.halt(instance_id: instance_id)
  end

  def test_bandwidth
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/bandwidth", response: stub_response(fixture: "instances/bandwidth"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.bandwidth(instance_id: instance_id)

    assert_equal Vultr::Object, instance.class
  end

  def test_neighbors
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/neighbors", response: stub_response(fixture: "instances/neighbors"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.neighbors(instance_id: instance_id)

    assert_equal Array, instance.class
  end

  def test_user_data
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/user-data", response: stub_response(fixture: "instances/user_data"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.user_data(instance_id: instance_id)

    assert_equal Vultr::Object, instance.class
    assert_equal "QmFzZTY0IEV4YW1wbGUgRGF0YQ==", instance.data
  end

  def test_upgrades
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/upgrades", response: stub_response(fixture: "instances/upgrades"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.upgrades(instance_id: instance_id)

    assert_equal Vultr::Object, instance.class
    assert_equal "Example CentOS 6 x64", instance.os.first["name"]
  end

  def test_list_ipv4
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/ipv4", response: stub_response(fixture: "instances/list_ipv4"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.list_ipv4(instance_id: instance_id)

    assert_equal Vultr::Collection, instance.class
    assert_equal 3, instance.total
  end

  def test_create_ipv4
    body = {reboot: true}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/ipv4", method: :post, body: body, response: stub_response(fixture: "instances/ipv4", status: 202))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.create_ipv4(instance_id: instance_id, **body)

    assert_equal Vultr::Object, instance.class
  end

  def test_delete_ipv4
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    ipv4_id = "192.0.2.123"
    stub = stub_request("instances/#{instance_id}/ipv4/#{ipv4_id}", method: :delete, response: stub_response(fixture: "instances/delete_ipv4", status: 204))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.delete_ipv4(instance_id: instance_id, ipv4: ipv4_id)
  end

  def test_create_ipv4_reverse
    body = {ip: "192.0.2.123", reverse: "foo.example.com"}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/ipv4/reverse", method: :post, body: body, response: stub_response(fixture: "instances/create_ipv4_reverse", status: 202))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.create_ipv4_reverse(instance_id: instance_id, **body)
  end

  def test_set_default_reverse_dns_entry
    body = {ip: "192.0.2.123"}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/ipv4/reverse/default", method: :post, body: body, response: stub_response(fixture: "instances/set_default_reverse_dns_entry"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.set_default_reverse_dns_entry(instance_id: instance_id, **body)
  end

  def test_list_ipv6
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/ipv6", response: stub_response(fixture: "instances/list_ipv6"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.list_ipv6(instance_id: instance_id)

    assert_equal Vultr::Collection, instance.class
    assert_equal 1, instance.total
  end

  def test_ipv6_reverse
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/ipv6/reverse", response: stub_response(fixture: "instances/ipv6_reverse"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.ipv6_reverse(instance_id: instance_id)

    assert_equal Vultr::Collection, instance.class
    assert_equal 1, instance.total
  end

  def test_create_ipv6_reverse
    body = {ip: "2001:0db8:0005:6bb0:5400:2ff0:fee5:0002", reverse: "foo.example.com"}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/ipv6/reverse", method: :post, body: body, response: stub_response(fixture: "instances/create_ipv6_reverse", status: 202))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.create_ipv6_reverse(instance_id: instance_id, **body)
  end

  def test_delete_ipv6_reverse
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    ipv6_id = "2001:0db8:0005:6bb0:5400:2ff0:fee5:0002"
    stub = stub_request("instances/#{instance_id}/ipv6/reverse/#{ipv6_id}", method: :delete, response: stub_response(fixture: "instances/delete_ipv6", status: 204))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.delete_ipv6_reverse(instance_id: instance_id, ipv6: ipv6_id)
  end

  def test_list_private_networks
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/private-networks", response: stub_response(fixture: "instances/list_private_networks"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.list_private_networks(instance_id: instance_id)

    assert_equal Vultr::Collection, instance.class
    assert_equal 1, instance.total
  end

  def test_attach_private_network
    body = {network_id: "cb676a46-66fd-4dfb-b839-443f2e6c0b60"}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/private-networks/attach", method: :post, body: body, response: stub_response(fixture: "instances/attach_private_network"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.attach_private_network(instance_id: instance_id, **body)
  end

  def test_detach_private_network
    body = {network_id: "cb676a46-66fd-4dfb-b839-443f2e6c0b60"}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/private-networks/detach", method: :post, body: body, response: stub_response(fixture: "instances/detach_private_network"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.detach_private_network(instance_id: instance_id, **body)
  end

  def test_iso
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/iso", response: stub_response(fixture: "instances/iso"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.iso(instance_id: instance_id)

    assert_equal Vultr::Object, instance.class
  end

  def test_attach_iso
    body = {iso_id: "cb676a46-66fd-4dfb-b839-443f2e6c0b60"}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/iso/attach", method: :post, body: body, response: stub_response(fixture: "instances/attach_iso", status: 204))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.attach_iso(instance_id: instance_id, iso_id: body[:iso_id])

    assert_equal Vultr::Object, instance.class
  end

  def test_detach_iso
    body = {iso_id: "cb676a46-66fd-4dfb-b839-443f2e6c0b60"}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/iso/detach", method: :post, body: body, response: stub_response(fixture: "instances/detach_iso"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.detach_iso(instance_id: instance_id, iso_id: body[:iso_id])

    assert_equal Vultr::Object, instance.class
  end

  def test_backup_schedule
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/backup-schedule", response: stub_response(fixture: "instances/backup_schedule"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    instance = client.instances.backup_schedule(instance_id: instance_id)

    assert_equal Vultr::Object, instance.class
  end

  def test_set_backup_schedule
    body = {type: "daily", hour: 10, dow: 1, dom: 1}
    instance_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("instances/#{instance_id}/backup-schedule", method: :post, body: body, response: stub_response(fixture: "instances/set_backup_schedule"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.set_backup_schedule(instance_id: instance_id, **body)
  end

  def test_halt_instances
    body = {
      instance_ids: [
        "cb676a46-66fd-4dfb-b839-443f2e6c0b60",
        "1d651bd2-b93c-4bb6-8b91-0546fd765f15",
        "c2790719-278d-474c-8dff-cb35d6e5503f"
      ]
    }

    stub = stub_request("instances/halt", method: :post, body: body, response: stub_response(fixture: "instances/halt_instances"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.halt_instances(instance_ids: body[:instance_ids], **body)
  end

  def test_reboot_instances
    body = {
      instance_ids: [
        "cb676a46-66fd-4dfb-b839-443f2e6c0b60",
        "1d651bd2-b93c-4bb6-8b91-0546fd765f15",
        "c2790719-278d-474c-8dff-cb35d6e5503f"
      ]
    }

    stub = stub_request("instances/reboot", method: :post, body: body, response: stub_response(fixture: "instances/reboot_instances"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.reboot_instances(instance_ids: body[:instance_ids], **body)
  end

  def test_start_instances
    body = {
      instance_ids: [
        "cb676a46-66fd-4dfb-b839-443f2e6c0b60",
        "1d651bd2-b93c-4bb6-8b91-0546fd765f15",
        "c2790719-278d-474c-8dff-cb35d6e5503f"
      ]
    }

    stub = stub_request("instances/start", method: :post, body: body, response: stub_response(fixture: "instances/start_instances"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.instances.start_instances(instance_ids: body[:instance_ids], **body)
  end
end
