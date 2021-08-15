module Vultr
  class ObjectStorageResource < Resource
    def list(**params)
      response = get_request("object-storage", params: params)
      Collection.from_response(response: response, key: "object_storages", type: ObjectStorage)
    end

    def retrieve(id)
      ObjectStorage.new get_request("object-storage/#{id}").body.dig("object_storage")
    end

    def create(**attributes)
      ObjectStorage.new post_request("object-storage", body: attributes).body.dig("object_storage")
    end

    def update(id, **attributes)
      put_request("object-storage/#{id}", body: attributes)
    end

    def delete(id)
      delete_request("object-storage/#{id}")
    end

    def regenerate_keys(id)
      Object.new post_request("object-storage/#{id}/regenerate-keys").body
    end

    def list_clusters(**params)
      response = get_request("object-storage/clusters", params: params)
      Collection.from_response(response: response, key: "clusters", type: Object)
    end
  end
end
