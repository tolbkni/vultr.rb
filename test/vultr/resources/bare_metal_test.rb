# frozen_string_literal: true

require "test_helper"

class BareMetalResourceTest < Minitest::Test
  def test_list
    stub = stub_request("bare-metals", response: stub_response(fixture: "bare_metals/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    bare_metal = client.bare_metal.list

    assert_equal Vultr::Collection, bare_metal.class
    assert_equal Vultr::BareMetal, bare_metal.data.first.class
    assert_equal 1, bare_metal.total
    assert_equal "next", bare_metal.next_cursor
    assert_equal "prev", bare_metal.prev_cursor
  end

  def test_create
    body = {region: "ams", plan: "vbm-4c-32gb", label: "Example Bare Metal", app_id: 3, enable_ipv6: true}
    stub = stub_request("bare-metals", method: :post, body: body, response: stub_response(fixture: "bare_metals/create", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    bare_metal = client.bare_metal.create(**body)

    assert_equal bare_metal.region, "ams"
    assert_equal bare_metal.date_created, Time.parse("2020-10-10T01:56:20+00:00")
    assert_equal bare_metal.plan, "vbm-4c-32gb"
    assert_equal bare_metal.label, "Example Bare Metal"
    assert_equal bare_metal.features, ["ipv6"]
  end

  def test_retrieve
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}", response: stub_response(fixture: "bare_metals/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    bare_metal = client.bare_metal.retrieve(baremetal_id: baremetal_id)

    assert_equal bare_metal.id, baremetal_id
    assert_equal bare_metal.os, "Application"
    assert_equal bare_metal.ram, "32768 MB"
    assert_equal bare_metal.disk, "2x 240GB SSD"
    assert_equal bare_metal.main_ip, "192.0.2.123"
    assert_equal bare_metal.cpu_count, 4
    assert_equal bare_metal.region, "ams"
    assert_equal bare_metal.date_created, Time.parse("2020-10-10T01:56:20+00:00")
    assert_equal bare_metal.status, "pending"
    assert_equal bare_metal.netmask_v4, "255.255.254.0"
    assert_equal bare_metal.gateway_v4, "192.0.2.1"
    assert_equal bare_metal.plan, "vbm-4c-32gb"
    assert_equal bare_metal.v6_network, "2001:0db8:5001:3990::"
    assert_equal bare_metal.v6_main_ip, "2001:0db8:5001:3990:0ec4:7aff:fe8e:f97a"
    assert_equal bare_metal.v6_network_size, 64
    assert_equal bare_metal.mac_address, 2199756823533
    assert_equal bare_metal.label, "Example Bare Metal"
    assert_equal bare_metal.tag, "Example Tag"
    assert_equal bare_metal.os_id, 183
    assert_equal bare_metal.app_id, 3
    assert_equal bare_metal.image_id, ""
    assert_equal bare_metal.features, ["ipv6"]
  end

  def test_update
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {label: "Updated Bare Metal Label", tag: "Updated Tag", user_data: "QmFzZTY0IEV4YW1wbGUgRGF0YQ=="}
    stub = stub_request("bare-metals/#{baremetal_id}", method: :patch, body: body, response: stub_response(fixture: "bare_metals/update", status: 202))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    bare_metal = client.bare_metal.update(baremetal_id: baremetal_id, **body)

    assert_equal bare_metal.id, baremetal_id
    assert_equal bare_metal.os, "Application"
    assert_equal bare_metal.ram, "32768 MB"
    assert_equal bare_metal.disk, "2x 240GB SSD"
    assert_equal bare_metal.main_ip, "192.0.2.123"
    assert_equal bare_metal.cpu_count, 4
    assert_equal bare_metal.region, "ams"
    assert_equal bare_metal.date_created, Time.parse("2020-10-10T01:56:20+00:00")
    assert_equal bare_metal.status, "pending"
    assert_equal bare_metal.netmask_v4, "255.255.254.0"
    assert_equal bare_metal.gateway_v4, "192.0.2.1"
    assert_equal bare_metal.plan, "vbm-4c-32gb"
    assert_equal bare_metal.v6_network, "2001:0db8:5001:3990::"
    assert_equal bare_metal.v6_main_ip, "2001:0db8:5001:3990:0ec4:7aff:fe8e:f97a"
    assert_equal bare_metal.v6_network_size, 64
    assert_equal bare_metal.mac_address, 2199756823533
    assert_equal bare_metal.label, "Updated Bare Metal Label"
    assert_equal bare_metal.tag, "Updated Tag"
    assert_equal bare_metal.os_id, 183
    assert_equal bare_metal.app_id, 3
    assert_equal bare_metal.image_id, ""
    assert_equal bare_metal.features, ["ipv6"]
  end

  def test_delete
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}", method: :delete, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.bare_metal.delete(baremetal_id: baremetal_id)
  end

  def test_start
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}/start", method: :post, body: {}, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.bare_metal.start(baremetal_id: baremetal_id)
  end

  def test_reboot
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}/reboot", method: :post, body: {}, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.bare_metal.reboot(baremetal_id: baremetal_id)
  end

  def test_reinstall
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}/reinstall", method: :post, body: {}, response: stub_response(fixture: "bare_metals/reinstall", status: 202))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    bare_metal = client.bare_metal.reinstall(baremetal_id: baremetal_id)

    assert_equal bare_metal.id, baremetal_id
    assert_equal bare_metal.os, "Application"
    assert_equal bare_metal.ram, "32768 MB"
    assert_equal bare_metal.disk, "2x 240GB SSD"
    assert_equal bare_metal.main_ip, "192.0.2.123"
    assert_equal bare_metal.cpu_count, 4
    assert_equal bare_metal.region, "ams"
    assert_equal bare_metal.date_created, Time.parse("2020-10-10T01:56:20+00:00")
    assert_equal bare_metal.status, "pending"
    assert_equal bare_metal.netmask_v4, "255.255.254.0"
    assert_equal bare_metal.gateway_v4, "192.0.2.1"
    assert_equal bare_metal.plan, "vbm-4c-32gb"
    assert_equal bare_metal.v6_network, "2001:0db8:5001:3990::"
    assert_equal bare_metal.v6_main_ip, "2001:0db8:5001:3990:0ec4:7aff:fe8e:f97a"
    assert_equal bare_metal.v6_network_size, 64
    assert_equal bare_metal.label, "Example Bare Metal"
    assert_equal bare_metal.mac_address, 2199756823533
    assert_equal bare_metal.tag, "Example Tag"
    assert_equal bare_metal.os_id, 183
    assert_equal bare_metal.app_id, 3
    assert_equal bare_metal.image_id, ""
  end

  def test_halt
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}/halt", method: :post, body: {}, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.bare_metal.halt(baremetal_id: baremetal_id)
  end

  def test_bandwidth
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}/bandwidth", method: :get, response: stub_response(fixture: "bare_metals/bandwidth"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    bandwidth = client.bare_metal.bandwidth(baremetal_id: baremetal_id)

    assert_equal bandwidth["2020-07-25"].class, OpenStruct
    assert_equal bandwidth["2020-07-25"].incoming_bytes, 15989787
    assert_equal bandwidth["2020-07-25"].outgoing_bytes, 25327729

    assert_equal bandwidth["2020-07-26"].class, OpenStruct
    assert_equal bandwidth["2020-07-26"].incoming_bytes, 13964112
    assert_equal bandwidth["2020-07-26"].outgoing_bytes, 22257069
  end

  def test_user_data
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}/user-data", method: :get, response: stub_response(fixture: "bare_metals/user_data"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    user_data = client.bare_metal.user_data(baremetal_id: baremetal_id)

    assert_equal user_data.data, "QmFzZTY0IEV4YW1wbGUgRGF0YQ=="
  end

  def test_upgrades
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}/upgrades", method: :get, response: stub_response(fixture: "bare_metals/upgrades"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    upgrades = client.bare_metal.upgrades(baremetal_id: baremetal_id)

    assert_equal upgrades.os.class, Array
    assert_equal upgrades.applications.class, Array
  end

  def test_vnc
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}/vnc", method: :get, response: stub_response(fixture: "bare_metals/vnc"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    vnc = client.bare_metal.vnc(baremetal_id: baremetal_id)

    assert_equal vnc.url, "https://my.vultr.com/subs/baremetal/novnc/api.php?data=00example11223344"
  end

  def test_list_ipv4
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}/ipv4", method: :get, response: stub_response(fixture: "bare_metals/list_ipv4"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    ipv4 = client.bare_metal.list_ipv4(baremetal_id: baremetal_id)

    assert_equal Vultr::Collection, ipv4.class
    assert_equal Vultr::Object, ipv4.data.first.class
    assert_equal 1, ipv4.total
    assert_equal "next", ipv4.next_cursor
    assert_equal "prev", ipv4.prev_cursor
  end

  def test_list_ipv6
    baremetal_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("bare-metals/#{baremetal_id}/ipv6", method: :get, response: stub_response(fixture: "bare_metals/list_ipv6"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    ipv6 = client.bare_metal.list_ipv6(baremetal_id: baremetal_id)

    assert_equal Vultr::Collection, ipv6.class
    assert_equal Vultr::Object, ipv6.data.first.class
    assert_equal 1, ipv6.total
    assert_equal "next", ipv6.next_cursor
    assert_equal "prev", ipv6.prev_cursor
  end

  def test_halt_instances
    baremetal_ids = [
      "cb676a46-66fd-4dfb-b839-443f2e6c0b60",
      "7f6f84ea-8f87-4d9e-af01-ac44db05911c",
      "54a83807-64ce-42e8-a0da-4d6c31c5b93b"
    ]

    stub = stub_request("bare-metals/halt", method: :post, body: {baremetal_ids: baremetal_ids}, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.bare_metal.halt_instances(baremetal_ids: baremetal_ids)
  end

  def test_reboot_instances
    baremetal_ids = [
      "cb676a46-66fd-4dfb-b839-443f2e6c0b60",
      "7f6f84ea-8f87-4d9e-af01-ac44db05911c",
      "54a83807-64ce-42e8-a0da-4d6c31c5b93b"
    ]

    stub = stub_request("bare-metals/reboot", method: :post, body: {baremetal_ids: baremetal_ids}, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.bare_metal.reboot_instances(baremetal_ids: baremetal_ids)
  end

  def test_start_instances
    baremetal_ids = [
      "cb676a46-66fd-4dfb-b839-443f2e6c0b60",
      "7f6f84ea-8f87-4d9e-af01-ac44db05911c",
      "54a83807-64ce-42e8-a0da-4d6c31c5b93b"
    ]

    stub = stub_request("bare-metals/start", method: :post, body: {baremetal_ids: baremetal_ids}, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.bare_metal.start_instances(baremetal_ids: baremetal_ids)
  end
end
