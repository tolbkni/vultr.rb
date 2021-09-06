module Vultr
  class UserResource < Resource
    def list(**params)
      response = get_request("users", params: params)
      Collection.from_response(response, key: "users", type: User)
    end

    def create(**attributes)
      User.new post_request("users", body: attributes).body.dig("user")
    end

    def retrieve(user_id:)
      User.new get_request("users/#{user_id}").body.dig("user")
    end

    def update(user_id:, **attributes)
      patch_request("users/#{user_id}", body: attributes)
    end

    def delete(user_id:)
      delete_request("users/#{user_id}")
    end
  end
end
