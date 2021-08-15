module Vultr
  class StartupScriptsResource < Resource
    def list(**params)
      response = get_request("startup-scripts", params: params)
      Collection.from_response(response: response, key: "startup_scripts", type: StartupScript)
    end

    def retrieve(id)
      StartupScript.new get_request("startup-scripts/#{id}").body.dig("startup_script")
    end

    def create(**attributes)
      StartupScript.new post_request("startup-scripts", body: attributes).body.dig("startup_script")
    end

    def update(id, **attributes)
      patch_request("startup-scripts/#{id}", body: attributes)
    end

    def delete(id)
      delete_request("startup-scripts/#{id}")
    end
  end
end
