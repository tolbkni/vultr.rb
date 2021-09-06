module Vultr
  class LoadBalancersResource < Resource
    def list(**params)
      response = get_request("load-balancers", params: params)
      Collection.from_response(response, key: "load_balancers", type: LoadBalancer)
    end

    def create(**attributes)
      LoadBalancer.new post_request("load-balancers", body: attributes).body.dig("load_balancer")
    end

    def retrieve(load_balancer_id:)
      LoadBalancer.new get_request("load-balancers/#{load_balancer_id}").body.dig("load_balancer")
    end

    def update(load_balancer_id:, **attributes)
      LoadBalancer.new patch_request("load-balancers/#{load_balancer_id}", body: attributes).body.dig("load_balancer")
    end

    def delete(load_balancer_id:)
      delete_request("load-balancers/#{load_balancer_id}")
    end

    def list_forwarding_rules(load_balancer_id:, **params)
      response = get_request("load-balancers/#{load_balancer_id}/forwarding-rules", params: params)
      Collection.from_response(response, key: "forwarding_rules", type: Object)
    end

    def create_forwarding_rule(load_balancer_id:, **attributes)
      Object.new post_request("load-balancers/#{load_balancer_id}/forwarding-rules", body: attributes).body.dig("forwarding_rule")
    end

    def retrieve_forwarding_rule(load_balancer_id:, forwarding_rule_id:)
      Object.new get_request("load-balancers/#{load_balancer_id}/forwarding-rules/#{forwarding_rule_id}").body.dig("forwarding_rule")
    end

    def delete_forwarding_rule(load_balancer_id:, forwarding_rule_id:)
      delete_request("load-balancers/#{load_balancer_id}/forwarding-rules/#{forwarding_rule_id}")
    end

    def list_firewall_rules(load_balancer_id:, **params)
      response = get_request("load-balancers/#{load_balancer_id}/firewall-rules", params: params)
      Collection.from_response(response, key: "firewall_rules", type: Object)
    end

    def retrieve_firewall_rule(load_balancer_id:, firewall_rule_id:)
      Object.new get_request("load-balancers/#{load_balancer_id}/firewall-rules/#{firewall_rule_id}").body.dig("firewall_rule")
    end
  end
end
