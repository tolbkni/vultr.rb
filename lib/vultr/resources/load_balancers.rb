module Vultr
  class LoadBalancersResource < Resource
    def list(**params)
      response = get_request("load-balancers", params: params)
      Collection.from_response(response: response, key: "load_balancers", type: LoadBalancer)
    end

    def retrieve(id)
      LoadBalancer.new get_request("load-balancers/#{id}").body.dig("load_balancer")
    end

    def create(**attributes)
      LoadBalancer.new post_request("load-balancers", body: attributes).body.dig("load_balancer")
    end

    def update(id, **attributes)
      LoadBalancer.new patch_request("load-balancers/#{id}", body: attributes).body.dig("load_balancer")
    end

    def delete(id)
      delete_request("load-balancers/#{id}")
    end

    def list_forwarding_rules(id, **params)
      response = get_request("load-balancers/#{id}/forwarding-rules", params: params)
      Collection.from_response(response: response, key: "forwarding_rules", type: Object)
    end

    def retrieve_forwarding_rule(id, rule_id:)
      Object.new get_request("load-balancers/#{id}/forwarding-rules/#{rule_id}").body.dig("forwarding_rule")
    end

    def create_forwarding_rule(id, **attributes)
      Object.new post_request("load-balancers/#{id}/forwarding-rules", body: attributes).body.dig("forwarding_rule")
    end

    def delete_forwarding_rule(id, rule_id:)
      delete_request("load-balancers/#{id}/forwarding-rules/#{rule_id}")
    end

    def list_firewall_rules(id, **params)
      response = get_request("load-balancers/#{id}/firewall-rules", params: params)
      Collection.from_response(response: response, key: "firewall_rules", type: Object)
    end

    def retrieve_firewall_rule(id, rule_id:)
      Object.new get_request("load-balancers/#{id}/firewall-rules/#{rule_id}").body.dig("firewall_rule")
    end
  end
end
