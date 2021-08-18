module Vultr
  class BackupsResource < Resource
    def list(**params)
      response = get_request("backups", params: params)
      Collection.from_response(response, key: "backups", type: Backup)
    end

    def retrieve(backup_id:)
      Backup.new get_request("backups/#{backup_id}").body.dig("backup")
    end
  end
end
