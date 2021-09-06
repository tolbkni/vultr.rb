# frozen_string_literal: true

require "test_helper"

class BlockStorageResourceTest < Minitest::Test
  def test_list
    stub = stub_request("blocks", response: stub_response(fixture: "block_storage/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    blocks = client.block_storage.list

    assert_equal Vultr::Collection, blocks.class
    assert_equal Vultr::BlockStorage, blocks.data.first.class
    assert_equal 1, blocks.total
    assert_equal "next", blocks.next_cursor
    assert_equal "prev", blocks.prev_cursor
  end

  def test_create
    body = {region: "ewr", size_gb: 50, label: "Example Block Storage"}
    stub = stub_request("blocks", method: :post, body: body, response: stub_response(fixture: "block_storage/create", status: 202))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    blocks = client.block_storage.create(**body)

    assert_equal blocks.id, "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    assert_equal blocks.date_created, Time.parse("2020-10-10T01:56:20+00:00")
    assert_equal blocks.cost, 5
    assert_equal blocks.status, "active"
    assert_equal blocks.size_gb, 50
    assert_equal blocks.region, "ewr"
    assert_equal blocks.attached_to_instance, "742c9913-d088-4d67-bc61-5a10e922fbd1"
    assert_equal blocks.label, "Example Block Storage"
    assert_equal blocks.mount_id, "ewr-example112233"
  end

  def test_retrieve
    block_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {region: "ewr", size_gb: 50, label: "Example Block Storage"}
    stub = stub_request("blocks/#{block_id}", body: body, response: stub_response(fixture: "block_storage/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    blocks = client.block_storage.retrieve(block_id: block_id)

    assert_equal blocks.id, "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    assert_equal blocks.date_created, Time.parse("2020-10-10T01:56:20+00:00")
    assert_equal blocks.cost, 5
    assert_equal blocks.status, "active"
    assert_equal blocks.size_gb, 50
    assert_equal blocks.region, "ewr"
    assert_equal blocks.attached_to_instance, "742c9913-d088-4d67-bc61-5a10e922fbd1"
    assert_equal blocks.label, "Example Block Storage"
    assert_equal blocks.mount_id, "ewr-example112233"
  end

  def test_update
    block_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {size_gb: 50, label: "Example Block Storage"}
    stub = stub_request("blocks/#{block_id}", method: :patch, body: body, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.block_storage.update(block_id: block_id, **body)
  end

  def test_delete
    block_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("blocks/#{block_id}", method: :delete, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.block_storage.delete(block_id: block_id)
  end

  def test_attach
    block_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("blocks/#{block_id}/attach", method: :post, response: stub_response(fixture: "block_storage/attach"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.block_storage.attach(block_id: block_id)
  end

  def test_detach
    block_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("blocks/#{block_id}/detach", method: :post, response: stub_response(fixture: "block_storage/detach"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.block_storage.detach(block_id: block_id)
  end
end
