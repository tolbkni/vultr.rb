# frozen_string_literal: true

require "test_helper"

class UsersResourceTest < Minitest::Test
  def test_list
    stub = stub_request("users", response: stub_response(fixture: "users/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    users = client.users.list

    assert_equal Vultr::Collection, users.class
    assert_equal Vultr::User, users.data.first.class
    assert_equal 1, users.total
  end

  def test_create
    body = {name: "Test user", email: "user@example.com", password: "password"}
    stub = stub_request("users", method: :post, body: body, response: stub_response(fixture: "users/create", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    user = client.users.create(**body)

    assert_equal Vultr::User, user.class
    assert_equal "user@example.com", user.email
  end

  def test_retrieve
    user_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("users/#{user_id}", response: stub_response(fixture: "users/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    user = client.users.retrieve(user_id: user_id)

    assert_equal Vultr::User, user.class
    assert_equal "user@example.com", user.email
  end

  def test_update
    user_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {name: "Changed"}
    stub = stub_request("users/#{user_id}", method: :patch, body: body, response: stub_response(fixture: "users/update"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.users.update(user_id: user_id, **body)
  end

  def test_delete
    user_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("users/#{user_id}", method: :delete, response: stub_response(fixture: "users/delete"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.users.delete(user_id: user_id)
  end
end
