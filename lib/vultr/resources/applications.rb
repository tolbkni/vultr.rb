module Vultr
  class ApplicationsResource < Resource
    def list(**params)
      response = get_request("applications", params: params)
      Collection.from_response(response, key: "applications", type: Application)
    end
  end
end
