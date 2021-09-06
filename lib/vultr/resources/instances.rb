module Vultr
  class InstancesResource < Resource
    def list(**params)
      response = get_request("instances", params: params)
      Collection.from_response(response, key: "instances", type: Instance)
    end

    def create(**attributes)
      Instance.new post_request("instances", body: attributes).body.dig("instance")
    end

    def retrieve(instance_id:)
      Instance.new get_request("instances/#{instance_id}").body.dig("instance")
    end

    def update(instance_id:, **attributes)
      patch_request("instances/#{instance_id}", body: attributes)
    end

    def delete(instance_id:)
      delete_request("instances/#{instance_id}")
    end

    def start(instance_id:, **attributes)
      post_request("instances/#{instance_id}/start", body: attributes)
    end

    def reboot(instance_id:, **attributes)
      post_request("instances/#{instance_id}/reboot", body: attributes)
    end

    def reinstall(instance_id:, **attributes)
      Instance.new post_request("instances/#{instance_id}/reinstall", body: attributes).body.dig("instance")
    end

    def restore(instance_id:, **attributes)
      Object.new post_request("instances/#{instance_id}/restore", body: attributes).body.dig("status")
    end

    def halt(instance_id:, **attributes)
      post_request("instances/#{instance_id}/halt", body: attributes)
    end

    def bandwidth(instance_id:)
      Object.new get_request("instances/#{instance_id}/bandwidth").body.dig("bandwidth")
    end

    def neighbors(instance_id:)
      get_request("instances/#{instance_id}/neighbors").body.dig("neighbors")
    end

    def user_data(instance_id:)
      Object.new get_request("instances/#{instance_id}/user-data").body.dig("user_data")
    end

    def upgrades(instance_id:, **params)
      Object.new get_request("instances/#{instance_id}/upgrades", params: params).body.dig("upgrades")
    end

    def list_ipv4(instance_id:, **params)
      response = get_request("instances/#{instance_id}/ipv4", params: params)
      Collection.from_response(response, key: "ipv4s", type: Object)
    end

    def create_ipv4(instance_id:, **params)
      Object.new post_request("instances/#{instance_id}/ipv4", body: params).body.dig("ipv4")
    end

    def delete_ipv4(instance_id:, ipv4:)
      delete_request("instances/#{instance_id}/ipv4/#{ipv4}")
    end

    def create_ipv4_reverse(instance_id:, **params)
      post_request("instances/#{instance_id}/ipv4/reverse", body: params)
    end

    def set_default_reverse_dns_entry(instance_id:, **params)
      post_request("instances/#{instance_id}/ipv4/reverse/default", body: params)
    end

    def list_ipv6(instance_id:, **params)
      response = get_request("instances/#{instance_id}/ipv6", params: params)
      Collection.from_response(response, key: "ipv6s", type: Object)
    end

    def ipv6_reverse(instance_id:)
      response = get_request("instances/#{instance_id}/ipv6/reverse")
      Collection.from_response(response, key: "reverse_ipv6s", type: Object)
    end

    def create_ipv6_reverse(instance_id:, **params)
      post_request("instances/#{instance_id}/ipv6/reverse", body: params)
    end

    def delete_ipv6_reverse(instance_id:, ipv6:)
      delete_request("instances/#{instance_id}/ipv6/reverse/#{ipv6}")
    end

    def list_private_networks(instance_id:, **params)
      response = get_request("instances/#{instance_id}/private-networks", params: params)
      Collection.from_response(response, key: "private_networks", type: PrivateNetwork)
    end

    def attach_private_network(instance_id:, network_id:)
      post_request("instances/#{instance_id}/private-networks/attach", body: {network_id: network_id})
    end

    def detach_private_network(instance_id:, network_id:)
      post_request("instances/#{instance_id}/private-networks/detach", body: {network_id: network_id})
    end

    def iso(instance_id:)
      Object.new get_request("instances/#{instance_id}/iso").body.dig("iso_status")
    end

    def attach_iso(instance_id:, iso_id:)
      Object.new post_request("instances/#{instance_id}/iso/attach", body: {iso_id: iso_id}).body.dig("iso_status")
    end

    def detach_iso(instance_id:, iso_id:)
      Object.new post_request("instances/#{instance_id}/iso/detach", body: {iso_id: iso_id}).body.dig("iso_status")
    end

    def backup_schedule(instance_id:)
      Object.new get_request("instances/#{instance_id}/backup-schedule").body.dig("backup_schedule")
    end

    def set_backup_schedule(instance_id:, **attributes)
      post_request("instances/#{instance_id}/backup-schedule", body: attributes)
    end

    # Bulk operations
    def halt_instances(instance_ids:)
      post_request("instances/halt", body: {instance_ids: Array(instance_ids)})
    end

    def reboot_instances(instance_ids:)
      post_request("instances/reboot", body: {instance_ids: Array(instance_ids)})
    end

    def start_instances(instance_ids:)
      post_request("instances/start", body: {instance_ids: Array(instance_ids)})
    end
  end
end
