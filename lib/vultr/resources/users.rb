module Vultr
  class UserResource < Resource
    def list(**params)
      response = get_request("users", params: params)
      Collection.from_response(response, key: "users", type: User)
    end

    def retrieve(id)
      User.new get_request("users/#{id}").body.dig("user")
    end

    def create(**attributes)
      User.new post_request("users", body: attributes).body.dig("user")
    end

    def update(id, **attributes)
      patch_request("users/#{id}", body: attributes)
    end

    def delete(id)
      delete_request("users/#{id}")
    end
  end
end
