module Vultr
  class StartupScriptsResource < Resource
    def
      StartupScript.new get("").body
    end
  end
end

