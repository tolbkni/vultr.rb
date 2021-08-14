module Vultr
  class BlockStorageResource < Resource
    def list
      BlockStorage.new get_request("blocks").body
    end
  end
end

