# frozen_string_literal: true

require "test_helper"

class SnapshotsResourceTest < Minitest::Test
  def test_list
    stub = stub_request("snapshots", response: stub_response(fixture: "snapshots/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    snapshots = client.snapshots.list

    assert_equal Vultr::Collection, snapshots.class
    assert_equal Vultr::Snapshot, snapshots.data.first.class
    assert_equal 1, snapshots.total
  end

  def test_create
    body = {instance_id: "cb676a46-66fd-4dfb-b839-443f2e6c0b60", description: "Example Snapshot"}
    stub = stub_request("snapshots", method: :post, body: body, response: stub_response(fixture: "snapshots/create", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    snapshot = client.snapshots.create(**body)

    assert_equal Vultr::Snapshot, snapshot.class
    assert_equal "Example Snapshot", snapshot.description
  end

  def test_retrieve
    snapshot_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("snapshots/#{snapshot_id}", response: stub_response(fixture: "snapshots/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    snapshot = client.snapshots.retrieve(snapshot_id: snapshot_id)

    assert_equal Vultr::Snapshot, snapshot.class
    assert_equal "Example Snapshot", snapshot.description
  end

  def test_create_from_url
    body = {url: "http://example.com/disk_image.raw"}
    stub = stub_request("snapshots/create-from-url", method: :post, body: body, response: stub_response(fixture: "snapshots/create_from_url"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    snapshot = client.snapshots.create_from_url(body[:url])

    assert_equal Vultr::Snapshot, snapshot.class
    assert_equal "Example Snapshot", snapshot.description
  end

  def test_update
    snapshot_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {description: "Changed"}
    stub = stub_request("snapshots/#{snapshot_id}", method: :put, body: body, response: stub_response(fixture: "snapshots/update"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.snapshots.update(snapshot_id: snapshot_id, **body)
  end

  def test_delete
    snapshot_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("snapshots/#{snapshot_id}", method: :delete, response: stub_response(fixture: "snapshots/delete"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.snapshots.delete(snapshot_id: snapshot_id)
  end
end
