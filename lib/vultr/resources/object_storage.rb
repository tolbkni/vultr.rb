module Vultr
  class ObjectStorageResource < Resource
    def list(**params)
      response = get_request("object-storage", params: params)
      Collection.from_response(response, key: "object_storages", type: ObjectStorage)
    end

    def create(**attributes)
      ObjectStorage.new post_request("object-storage", body: attributes).body.dig("object_storage")
    end

    def retrieve(object_storage_id:)
      ObjectStorage.new get_request("object-storage/#{object_storage_id}").body.dig("object_storage")
    end

    def update(object_storage_id:, **attributes)
      put_request("object-storage/#{object_storage_id}", body: attributes)
    end

    def delete(object_storage_id:)
      delete_request("object-storage/#{object_storage_id}")
    end

    def regenerate_keys(object_storage_id:)
      Object.new post_request("object-storage/#{object_storage_id}/regenerate-keys", body: {}).body
    end

    def list_clusters(**params)
      response = get_request("object-storage/clusters", params: params)
      Collection.from_response(response, key: "clusters", type: Object)
    end
  end
end
