module Vultr
  class StartupScriptsResource < Resource
    def list(**params)
      response = get_request("startup-scripts", params: params)
      Collection.from_response(response: response, key: "startup_scripts", type: StartupScript)
    end

    def create(**attributes)
      StartupScript.new post_request("startup-scripts", body: attributes).body.dig("startup_script")
    end

    def retrieve(startup_script_id:)
      StartupScript.new get_request("startup-scripts/#{startup_script_id}").body.dig("startup_script")
    end

    def update(startup_script_id:, **attributes)
      patch_request("startup-scripts/#{startup_script_id}", body: attributes)
    end

    def delete(startup_script_id:)
      delete_request("startup-scripts/#{startup_script_id}")
    end
  end
end
