module Vultr
  class SshKeysResource < Resource
    def list
      SshKey.new get_request("startup-scripts").body
    end
  end
end

