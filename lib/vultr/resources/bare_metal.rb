module Vultr
  class BareMetalResource < Resource
    def list
      BareMetal.new get_request("bare-metals").body
    end
  end
end

