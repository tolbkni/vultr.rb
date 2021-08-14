module Vultr
  class BackupsResource < Resource
    def list
      Backup.new get_request("backups").body
    end
  end
end

