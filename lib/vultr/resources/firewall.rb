module Vultr
  class FirewallResource < Resource
    def list
      FirewallGroup.new get_request("firewalls").body
    end
  end
end

