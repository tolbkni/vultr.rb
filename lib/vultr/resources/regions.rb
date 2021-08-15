module Vultr
  class RegionsResource < Resource
    def list(**params)
      response = get_request("regions", params: params)
      Collection.from_response(response, key: "regions", type: Region)
    end

    def list_availability(id)
      Object.new get_request("regions/#{id}/availability").body
    end
  end
end
