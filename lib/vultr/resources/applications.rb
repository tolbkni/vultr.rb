module Vultr
  class ApplicationsResource < Resource
    def list
      Application.new get_request("applications").body
    end
  end
end

