module Vultr
  class AccountResource < Resource
    def info
      Account.new get("account").body
    end
  end
end
