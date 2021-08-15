module Vultr
  class PlansResource < Resource
    def list(**params)
      response = get_request("plans", params: params)
      Collection.from_response(response, key: "plans", type: Plan)
    end

    def list_metal(**params)
      response = get_request("plans-metal", params: params)
      Collection.from_response(response, key: "plans_metal", type: Plan)
    end
  end
end
