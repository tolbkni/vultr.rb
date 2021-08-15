module Vultr
  class PrivateNetworksResource < Resource
    def list(**params)
      response = get_request("private-networks", params: params)
      Collection.from_response(response, key: "networks", type: PrivateNetwork)
    end

    def retrieve(id)
      PrivateNetwork.new get_request("private-networks/#{id}").body.dig("network")
    end

    def create(**attributes)
      PrivateNetwork.new post_request("private-networks", body: attributes).body.dig("network")
    end

    def update(id, **attributes)
      put_request("private-networks/#{id}", body: attributes)
    end

    def delete(id)
      delete_request("private-networks/#{id}")
    end
  end
end
