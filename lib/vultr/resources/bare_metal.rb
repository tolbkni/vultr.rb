module Vultr
  class BareMetalResource < Resource
    def list(**params)
      response = get_request("bare-metals", params: params)
      Collection.from_response(response, key: "bare_metals", type: BareMetal)
    end

    def create(**attributes)
      BareMetal.new post_request("bare-metals", body: attributes).body.dig("bare_metal")
    end

    def retrieve(baremetal_id:)
      BareMetal.new get_request("bare-metals/#{baremetal_id}").body.dig("bare_metal")
    end

    def update(baremetal_id:, **attributes)
      BareMetal.new patch_request("bare-metals/#{baremetal_id}", body: attributes).body.dig("bare_metal")
    end

    def delete(baremetal_id:)
      delete_request("bare-metals/#{baremetal_id}")
    end

    def start(baremetal_id:)
      post_request("bare-metals/#{baremetal_id}/start")
    end

    def reboot(baremetal_id:)
      post_request("bare-metals/#{baremetal_id}/reboot")
    end

    def reinstall(baremetal_id:)
      BareMetal.new post_request("bare-metals/#{baremetal_id}/reinstall").body.dig("bare_metal")
    end

    def halt(baremetal_id:)
      post_request("bare-metals/#{baremetal_id}/halt")
    end

    def bandwidth(baremetal_id:)
      Object.new get_request("bare-metals/#{baremetal_id}/bandwidth").body.dig("bandwidth")
    end

    def user_data(baremetal_id:)
      Object.new get_request("bare-metals/#{baremetal_id}/user-data").body.dig("user_data")
    end

    def upgrades(baremetal_id:, **params)
      Object.new get_request("bare-metals/#{baremetal_id}/upgrades", params: params).body.dig("upgrades")
    end

    def vnc(baremetal_id:)
      Object.new get_request("bare-metals/#{baremetal_id}/vnc", params: params).body.dig("vnc")
    end

    def list_ipv4(baremetal_id:, **params)
      response = get_request("bare-metals/#{baremetal_id}/ipv4", params: params)
      Collection.from_response(response, key: "ipv4s", type: Object)
    end

    def list_ipv6(baremetal_id:, **params)
      response = get_request("bare-metals/#{baremetal_id}/ipv6", params: params)
      Collection.from_response(response, key: "ipv6s", type: Object)
    end

    # Bulk operations
    def halt_instances(baremetal_ids:)
      post_request("bare-metals/halt", body: {baremetal_ids: Array(baremetal_ids)})
    end

    def reboot_instances(baremetal_ids:)
      post_request("bare-metals/reboot", body: {baremetal_ids: Array(baremetal_ids)})
    end

    def start_instances(baremetal_ids:)
      post_request("bare-metals/start", body: {baremetal_ids: Array(baremetal_ids)})
    end
  end
end
