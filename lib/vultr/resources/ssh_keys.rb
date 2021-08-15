module Vultr
  class SshKeysResource < Resource
    def list(**params)
      response = get_request("ssh-keys", params: params)
      Collection.from_response(response: response, key: "ssh_keys", type: SshKey)
    end

    def retrieve(id)
      SshKey.new get_request("ssh-keys/#{id}").body.dig("ssh_key")
    end

    def create(**attributes)
      SshKey.new post_request("ssh-keys", body: attributes).body.dig("ssh_key")
    end

    def update(id, **attributes)
      patch_request("ssh-keys/#{id}", body: attributes)
    end

    def delete(id)
      delete_request("ssh-keys/#{id}")
    end
  end
end
