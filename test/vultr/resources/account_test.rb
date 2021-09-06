require "test_helper"

class AccountResourceTest < Minitest::Test
  def test_info
    stub = stub_request("account", response: stub_response(fixture: "account/info"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    account = client.account.info

    assert_equal Vultr::Account, account.class
    assert_equal "admin@example.com", account.email
  end
end
