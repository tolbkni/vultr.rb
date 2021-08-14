module Vultr
  class DnsResource < Resource
    def list
      Domain.new get_request("domains").body
    end
  end
end

