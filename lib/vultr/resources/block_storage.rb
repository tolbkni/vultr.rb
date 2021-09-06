module Vultr
  class BlockStorageResource < Resource
    def list(**params)
      response = get_request("blocks", params: params)
      Collection.from_response(response, key: "blocks", type: BlockStorage)
    end

    def create(**attributes)
      BlockStorage.new post_request("blocks", body: attributes).body.dig("block")
    end

    def retrieve(block_id:)
      BlockStorage.new get_request("blocks/#{block_id}").body.dig("block")
    end

    def update(block_id:, **attributes)
      patch_request("blocks/#{block_id}", body: attributes)
    end

    def delete(block_id:)
      delete_request("blocks/#{block_id}")
    end

    def attach(block_id:)
      post_request("blocks/#{block_id}/attach", body: {})
    end

    def detach(block_id:)
      post_request("blocks/#{block_id}/detach", body: {})
    end
  end
end
