module Vultr
  class PlansResource < Resource
    def list
      Plan.new get_request("plans").body
    end

    def list_metal
      Plan.new get_request("plans-metal").body
    end
  end
end

