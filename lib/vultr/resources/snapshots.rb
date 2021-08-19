module Vultr
  class SnapshotsResource < Resource
    def list(**params)
      response = get_request("snapshots", params: params)
      Collection.from_response(response, key: "snapshots", type: Snapshot)
    end

    def create(**attributes)
      Snapshot.new post_request("snapshots", body: attributes).body.dig("snapshot")
    end

    def retrieve(snapshot_id:)
      Snapshot.new get_request("snapshots/#{snapshot_id}").body.dig("snapshot")
    end

    def create_from_url(url)
      Snapshot.new post_request("snapshots/create-from-url", body: {url: url}).body.dig("snapshot")
    end

    def update(snapshot_id:, **attributes)
      put_request("snapshots/#{snapshot_id}", body: attributes)
    end

    def delete(snapshot_id:)
      delete_request("snapshots/#{snapshot_id}")
    end
  end
end
