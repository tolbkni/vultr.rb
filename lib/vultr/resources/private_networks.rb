module Vultr
  class PrivateNetworksResource < Resource
    def list(**params)
      response = get_request("private-networks", params: params)
      Collection.from_response(response, key: "networks", type: PrivateNetwork)
    end

    def create(**attributes)
      PrivateNetwork.new post_request("private-networks", body: attributes).body.dig("network")
    end

    def retrieve(network_id:)
      PrivateNetwork.new get_request("private-networks/#{network_id}").body.dig("network")
    end

    def update(network_id:, **attributes)
      put_request("private-networks/#{network_id}", body: attributes)
    end

    def delete(network_id:)
      delete_request("private-networks/#{network_id}")
    end
  end
end
