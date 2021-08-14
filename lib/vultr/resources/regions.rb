module Vultr
  class RegionsResource < Resource
    def list
      Region.new get_request("regions").body
    end

    def list_availability(id)
      Region.new get_request("regions/#{id}/availability")
    end
  end
end

