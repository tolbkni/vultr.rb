module Vultr
  class BlockStorageResource < Resource
    def list(**params)
      response = get_request("blocks", params: params)
      Collection.from_response(response, key: "blocks", type: BlockStorage)
    end

    def retrieve(id)
      BlockStorage.new get_request("blocks/#{id}")
    end

    def create(**attributes)
      BlockStorage.new post_request("blocks", body: attributes).body.dig("block")
    end

    def update(id, **attributes)
      patch_request("blocks/#{id}", body: attributes)
    end

    def delete(id)
      delete_request("blocks/#{id}")
    end

    def attach(id, **params)
      post_request("blocks/#{id}/attach", body: params)
    end

    def detach(id)
      post_request("blocks/#{id}/detach", body: params)
    end
  end
end
