module Vultr
  class IsoResource < Resource
    def list(**params)
      response = get_request("iso", params: params)
      Collection.from_response(response, key: "isos", type: Iso)
    end

    def create(**attributes)
      Iso.new post_request("isos", body: attributes).body.dig("iso")
    end

    def retrieve(iso_id:)
      Iso.new get_request("isos/#{iso_id}").body.dig("iso")
    end

    def delete(iso_id:)
      delete_request("isos/#{iso_id}")
    end

    def list_public(**params)
      response = get_request("iso-public", params: params)
      Collection.from_response(response, key: "public_isos", type: Iso)
    end
  end
end
