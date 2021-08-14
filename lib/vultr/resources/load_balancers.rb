module Vultr
  class LoadBalancersResource < Resource
    def
      LoadBalancer.new get_request("load-balancers").body
    end
  end
end

