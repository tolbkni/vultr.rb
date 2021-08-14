module Vultr
  class ReservedIpsResource < Resource
    def list
      ReservedIps.new get_request("reserved-ips").body
    end
  end
end

