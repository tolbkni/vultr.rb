module Vultr
  class SnapshotsResource < Resource
    def list
      Snapshot.new get_request("snapshots").body
    end
  end
end

