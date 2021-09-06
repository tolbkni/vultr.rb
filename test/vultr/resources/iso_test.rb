require "test_helper"

class IsoResourceTest < Minitest::Test
  def test_list
    stub = stub_request("iso", response: stub_response(fixture: "isos/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    iso = client.iso.list

    keys = [:id, :date_created, :filename, :size, :md5sum, :sha512sum, :status]
    assert_equal Vultr::Collection, iso.class
    assert_equal Vultr::Iso, iso.data.first.class
    assert_equal keys, iso.data.first.to_h.keys
    assert_equal 1, iso.total
  end

  def test_create
    body = {url: "http://example.com/my-iso.iso"}
    stub = stub_request("iso", method: :post, body: body, response: stub_response(fixture: "isos/create", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    iso = client.iso.create(**body)

    assert_equal "cb676a46-66fd-4dfb-b839-443f2e6c0b60", iso.id
    assert_equal Time.parse("2020-10-10T01:56:20+00:00"), iso.date_created
    assert_equal "my-iso.iso", iso.filename
    assert_equal "pending", iso.status
  end

  def test_retrieve
    iso_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b604"
    stub = stub_request("iso/#{iso_id}", response: stub_response(fixture: "isos/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    iso = client.iso.retrieve(iso_id: iso_id)

    keys = [:id, :date_created, :filename, :size, :md5sum, :sha512sum, :status]
    assert_equal Vultr::Iso, iso.class
    assert_equal keys, iso.to_h.keys
  end

  def test_delete
    iso_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b604"
    stub = stub_request("iso/#{iso_id}", method: :delete, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.iso.delete(iso_id: iso_id)
  end

  def test_list_public
    stub = stub_request("iso-public", response: stub_response(fixture: "isos/list_public"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    iso = client.iso.list_public

    keys = [:id, :name, :description, :md5sum]
    assert_equal Vultr::Collection, iso.class
    assert_equal Vultr::Iso, iso.data.first.class
    assert_equal keys, iso.data.first.to_h.keys
    assert_equal 1, iso.total
  end
end
