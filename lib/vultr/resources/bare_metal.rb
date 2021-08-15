module Vultr
  class BareMetalResource < Resource
    def list(**params)
      response = get_request("bare-metals", params: params)
      Collection.from_response(response, key: "bare_metals", type: BareMetal)
    end

    def retrieve(id)
      BareMetal.new get_request("bare-metals/#{id}").body.dig("bare_metal")
    end

    def create(**attributes)
      BareMetal.new post_request("bare-metals", body: attributes).body.dig("bare_metal")
    end

    def update(id, **attributes)
      BareMetal.new patch_request("bare-metals/#{id}", body: attributes).body.dig("bare_metal")
    end

    def delete(id)
      delete_request("bare-metals/#{id}")
    end

    def start(id)
      post_request("bare-metals/#{id}/start")
    end

    def reboot(id)
      post_request("bare-metals/#{id}/reboot")
    end

    def reinstall(id)
      BareMetal.new post_request("bare-metals/#{id}/reinstall").body.dig("bare_metal")
    end

    def halt(id)
      post_request("bare-metals/#{id}/halt")
    end

    def bandwidth(id)
      Object.new get_request("bare-metals/#{id}/bandwidth").body.dig("bandwidth")
    end

    def user_data(id)
      Object.new get_request("bare-metals/#{id}/user-data").body.dig("user_data")
    end

    def upgrades(id, **params)
      Object.new get_request("bare-metals/#{id}/upgrades", params: params).body.dig("upgrades")
    end

    def vnc(id)
      Object.new get_request("bare-metals/#{id}/vnc", params: params).body.dig("vnc")
    end

    def list_ipv4(id, **params)
      response = get_request("bare-metals/#{id}/ipv4", params: params)
      Collection.from_response(response, key: "ipv4s", type: Object)
    end

    def list_ipv6(id, **params)
      response = get_request("bare-metals/#{id}/ipv6", params: params)
      Collection.from_response(response, key: "ipv6s", type: Object)
    end

    # Bulk operations
    def halt_instances(ids)
      post_request("bare-metals/halt", body: { baremetal_ids: Array(ids) })
    end

    def reboot_instances(ids)
      post_request("bare-metals/reboot", body: { baremetal_ids: Array(ids) })
    end

    def start_instances(ids)
      post_request("bare-metals/start", body: { baremetal_ids: Array(ids) })
    end
  end
end
