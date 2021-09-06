module Vultr
  class ReservedIpsResource < Resource
    def list(**params)
      response = get_request("reserved-ips", params: params)
      Collection.from_response(response, key: "reserved_ips", type: ReservedIp)
    end

    def create(**attributes)
      ReservedIp.new post_request("reserved-ips", body: attributes).body.dig("reserved_ip")
    end

    def retrieve(reserved_ip:)
      ReservedIp.new get_request("reserved-ips/#{reserved_ip}").body.dig("reserved_ip")
    end

    def delete(reserved_ip:)
      delete_request("reserved-ips/#{reserved_ip}")
    end

    def attach(reserved_ip:, instance_id:)
      post_request("reserved-ips/#{reserved_ip}/attach", body: {instance_id: instance_id})
    end

    def detach(reserved_ip:)
      post_request("reserved-ips/#{reserved_ip}/detach", body: {})
    end

    def convert(**attributes)
      ReservedIp.new post_request("reserved-ips/convert", body: attributes).body.dig("reserved_ip")
    end
  end
end
