require "test_helper"

class ErrorTest < Minitest::Test
  {
    400 => Vultr::BadRequest,
    401 => Vultr::Unauthorized,
    403 => Vultr::Forbidden,
    404 => Vultr::NotFound,
    429 => Vultr::RateLimited,
    500 => Vultr::ServerError,
    503 => Vultr::RateLimited
  }.each do |status, error_class|
    define_method :"test_#{status}_raises_#{error_class.name.split("::").last.downcase}" do
      stub = stub_request("account", response: [status, {"Content-Type" => "application/json"}, {error: "Nope"}.to_json])
      client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

      error = assert_raises(error_class) { client.account.info }
      assert_kind_of Vultr::Error, error
      assert_includes error.message, "Nope"
    end
  end
end
