module Vultr
  class FirewallResource < Resource
    def list(**params)
      response = get_request("firewalls", params: params)
      Collection.from_response(response, key: "firewall_groups", type: FirewallGroup)
    end

    def create(**attributes)
      FirewallGroup.new post_request("firewalls", body: attributes).body.dig("firewall_group")
    end

    def retrieve(firewall_group_id:)
      FirewallGroup.new get_request("firewalls/#{firewall_group_id}").body.dig("firewall_group")
    end

    def update(firewall_group_id:, **attributes)
      put_request("firewalls/#{firewall_group_id}", body: attributes)
    end

    def delete(firewall_group_id:)
      delete_request("firewalls/#{firewall_group_id}")
    end

    # Firewall Rules
    def list_rules(firewall_group_id:, **params)
      response = get_request("firewalls/#{firewall_group_id}/rules", params: params)
      Collection.from_response(response, key: "firewall_rules", type: Object)
    end

    def create_rule(firewall_group_id:, **attributes)
      Object.new post_request("firewalls/#{firewall_group_id}/rules", body: attributes).body.dig("firewall_rule")
    end

    def retrieve_rule(firewall_group_id:, firewall_rule_id:)
      Object.new get_request("firewalls/#{firewall_group_id}/rules/#{firewall_rule_id}").body.dig("firewall_rule")
    end

    def delete_rule(firewall_group_id:, firewall_rule_id:)
      delete_request("firewalls/#{firewall_group_id}/rules/#{firewall_rule_id}")
    end
  end
end
