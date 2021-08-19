module Vultr
  class OperatingSystemsResource < Resource
    def list(**params)
      response = get_request("os", params: params)
      Collection.from_response(response, key: "os", type: OperatingSystem)
    end
  end
end
