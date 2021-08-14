module Vultr
  class OperatingSystemsResource < Resource
    def
      OperatingSystem.new get_request("os").body
    end
  end
end

