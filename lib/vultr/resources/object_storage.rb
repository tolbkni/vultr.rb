module Vultr
  class ObjectStorageResource < Resource
    def
      ObjectStorage.new get_request("object-storage").body
    end
  end
end

