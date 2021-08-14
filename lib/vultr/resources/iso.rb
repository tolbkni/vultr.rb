module Vultr
  class IsoResource < Resource
    def
      Iso.new get_request("iso").body
    end
  end
end

