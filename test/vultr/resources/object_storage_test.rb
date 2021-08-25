# frozen_string_literal: true

require "test_helper"

class ObjectStorageResourceTest < Minitest::Test
  def test_list
    stub = stub_request("object-storage", response: stub_response(fixture: "object_storage/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    object_storage = client.object_storage.list

    assert_equal Vultr::Collection, object_storage.class
    assert_equal Vultr::ObjectStorage, object_storage.data.first.class
    assert_equal 1, object_storage.total
  end

  def test_create
    body = {label: "Example Object Storage", cluster_id: 2}
    stub = stub_request("object-storage", method: :post, body: body, response: stub_response(fixture: "object_storage/create"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    object_storage = client.object_storage.create(**body)

    assert_equal Vultr::ObjectStorage, object_storage.class
    assert_equal "Example Object Storage", object_storage.label
  end

  def test_retrieve
    object_storage_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("object-storage/#{object_storage_id}", response: stub_response(fixture: "object_storage/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    object_storage = client.object_storage.retrieve(object_storage_id: object_storage_id)

    assert_equal Vultr::ObjectStorage, object_storage.class
    assert_equal "Example Object Storage", object_storage.label
  end

  def test_update
    object_storage_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {label: "Updated Object Storage Label"}
    stub = stub_request("object-storage/#{object_storage_id}", method: :put, body: body, response: stub_response(fixture: "object_storage/create"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.object_storage.update(object_storage_id: object_storage_id, **body)
  end

  def test_delete
    object_storage_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("object-storage/#{object_storage_id}", method: :delete, response: stub_response(fixture: "object_storage/delete"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.object_storage.delete(object_storage_id: object_storage_id)
  end

  def test_regenerate_keys
    object_storage_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("object-storage/#{object_storage_id}/regenerate-keys", method: :post, response: stub_response(fixture: "object_storage/regenerate_keys", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    object_storage_keys = client.object_storage.regenerate_keys(object_storage_id: object_storage_id)

    assert_equal "ewr1.vultrobjects.com", object_storage_keys.dig("s3_credentials", "s3_hostname")
    assert_equal "00example11223344", object_storage_keys.dig("s3_credentials", "s3_access_key")
    assert_equal "00example1122334455667788990011", object_storage_keys.dig("s3_credentials", "s3_secret_key")
  end

  def test_list_clusters
    stub = stub_request("object-storage/clusters", response: stub_response(fixture: "object_storage/list_clusters"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    clusters = client.object_storage.list_clusters

    assert_equal Vultr::Collection, clusters.class
    assert_equal Vultr::Object, clusters.data.first.class
    assert_equal 1, clusters.total
  end
end
