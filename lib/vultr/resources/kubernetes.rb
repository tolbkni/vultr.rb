module Vultr
  class KubernetesResource < Resource
    def list(**params)
      response = get_request("kubernetes/clusters", params: params)
      Collection.from_response(response, key: "vke_clusters", type: KubernetesCluster)
    end

    def retrieve(id)
      KubernetesCluster.new get_request("kubernetes/clusters/#{id}").body.dig("vke_cluster")
    end

    def create(**attributes)
      KubernetesCluster.new post_request("kubernetes/clusters", body: attributes).body.dig("vke_cluster")
    end

    def update(id, **attributes)
      put_request("kubernetes/clusters/#{id}", body: attributes)
    end

    def delete(id)
      delete_request("kubernetes/clusters/#{id}")
    end

    def config(id)
      Object.new get_request("kubernetes/clusters/#{id}/config").body
    end

    def list_resources(id, **params)
      response = get_request("kubernetes/clusters/#{id}/resources", params: params)
      Collection.from_response(response, key: "resources", type: Object)
    end

    def list_node_pools(id, **params)
      response = get_request("kubernetes/clusters/#{id}/node-pools", params: params)
      Collection.from_response(response, key: "node_pools", type: Object)
    end

    def retrieve_node_pool(id, nodepool_id:)
      Object.new get_request("kubernetes/clusters/#{id}/node-pools/#{nodepool_id}").body.dig("node_pool")
    end

    def create_node_pool(id, **attributes)
      Object.new post_request("kubernetes/clusters/#{id}/node-pools", body: attributes).body.dig("node_pool")
    end

    def update_node_pool(id, nodepool_id:, **attributes)
      Object.new patch_request("kubernetes/clusters/#{id}/node-pools/#{nodepool_id}", body: attributes).body.dig("node_pool")
    end

    def delete_node_pool(id, nodepool_id:)
      delete_request("kubernetes/clusters/#{id}/node-pools/#{nodepool_id}")
    end

    def delete_node_pool_instance(id, nodepool_id:, node_id:)
      delete_request("kubernetes/clusters/#{id}/node-pools/#{nodepool_id}/nodes/#{node_id}")
    end

    def recycle_node_pool_instance(id, nodepool_id:, node_id:)
      post_request("kubernetes/clusters/#{id}/node-pools/#{nodepool_id}/nodes/#{node_id}/recycle")
    end
  end
end
