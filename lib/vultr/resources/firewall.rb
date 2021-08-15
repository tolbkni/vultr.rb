module Vultr
  class FirewallResource < Resource
    def list(**params)
      response = get_request("firewalls", params: params)
      Collection.from_response(response: response, key: "firewall_groups", type: FirewallGroup)
    end

    def retrieve(id)
      FirewallGroup.new get_request("firewalls/#{id}").body.dig("firewall_group")
    end

    def create(**attributes)
      FirewallGroup.new post_request("firewalls", body: attributes).body.dig("firewall_group")
    end

    def update(id, **attributes)
      put_request("firewalls/#{id}", body: attributes)
    end

    def delete(id)
      delete_request("firewalls/#{id}")
    end

    # Firewall Rules
    def list_rules(id, **params)
      response = get_request("firewalls/#{id}/rules", params: params)
      Collection.from_response(response: response, key: "firewall_rules", type: Object)
    end

    def retrieve_rule(id, rule_id:)
      Object.new get_request("firewalls/#{id}/rules/#{rule_id}").body.dig("firewall_rule")
    end

    def create_rule(id, **attributes)
      Object.new post_request("firewalls/#{id}/rules", body: attributes).body.dig("firewall_rule")
    end

    def delete_rule(id, rule_id:)
      delete_request("firewalls/#{id}/rules/#{rule_id}")
    end
  end
end
