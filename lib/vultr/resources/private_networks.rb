module Vultr
  class PrivateNetworksResource < Resource
    def
      PrivateNetwork.new get_request("private-networks").body
    end
  end
end

