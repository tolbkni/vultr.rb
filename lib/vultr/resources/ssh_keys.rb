module Vultr
  class SshKeysResource < Resource
    def list(**params)
      response = get_request("ssh-keys", params: params)
      Collection.from_response(response, key: "ssh_keys", type: SshKey)
    end

    def create(**attributes)
      SshKey.new post_request("ssh-keys", body: attributes).body.dig("ssh_key")
    end

    def retrieve(ssh_key_id:)
      SshKey.new get_request("ssh-keys/#{ssh_key_id}").body.dig("ssh_key")
    end

    def update(ssh_key_id:, **attributes)
      patch_request("ssh-keys/#{ssh_key_id}", body: attributes)
    end

    def delete(ssh_key_id:)
      delete_request("ssh-keys/#{ssh_key_id}")
    end
  end
end
