module Vultr
  class BackupsResource < Resource
    def list(**params)
      response = get_request("backups", params: params)
      Collection.from_response(response, key: "backups", type: Backup)
    end

    def retrieve(id)
      Backup.new get_request("backups/#{id}").body.dig("backup")
    end
  end
end
