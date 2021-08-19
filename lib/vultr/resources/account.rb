module Vultr
  class AccountResource < Resource
    def info
      Account.new get_request("account").body.dig("account")
    end
  end
end
