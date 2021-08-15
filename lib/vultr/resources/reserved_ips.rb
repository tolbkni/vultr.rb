module Vultr
  class ReservedIpsResource < Resource
    def list(**params)
      response = get_request("reserved-ips", params: params)
      Collection.from_response(response, key: "reserved_ips", type: ReservedIp)
    end

    def retrieve(id)
      ReservedIp.new get_request("reserved-ips/#{id}").body.dig("reserved_ip")
    end

    def create(**attributes)
      ReservedIp.new post_request("reserved-ips", body: attributes).body.dig("reserved_ip")
    end

    def delete(id)
      delete_request("reserved-ips/#{id}")
    end

    def attach(id, reserved_ip:)
      post_request("reserved-ips/#{id}/attach", body: {reserved_ip: reserved_ip})
    end

    def detach(id)
      post_request("reserved-ips/#{id}/detach")
    end

    def convert(**attributes)
      ReservedIp.new post_request("reserved-ips/convert", body: attributes).body.dig("reserved_ip")
    end
  end
end
