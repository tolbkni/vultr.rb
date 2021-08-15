module Vultr
  class DnsResource < Resource
    def list(**params)
      response = get_request("domains", params: params)
      Collection.from_response(response, key: "domains", type: Domain)
    end

    def retrieve(id)
      Domain.new get_request("domains/#{id}")
    end

    def create(**attributes)
      Domain.new post_request("domains", body: attributes).body.dig("domain")
    end

    def update(id, **attributes)
      patch_request("domains/#{id}", body: attributes)
    end

    def delete(id)
      delete_request("domains/#{id}")
    end

    def soa(id)
      Object.new get_request("domains/#{id}/soa").body.dig("dns_soa")
    end

    def update_soa(id, **attributes)
      post_request("domains/#{id}/soa", body: attributes)
    end

    def dnssec(id)
      Object.new get_request("domains/#{id}/dnssec").body.dig("dns_sec")
    end

    def records(id, **params)
      response = get_request("domains/#{id}/records", params: params)
      Collection.from_response(response, key: "records", type: Object)
    end

    def retrieve_record(id, record_id:)
      Object.new get_request("domains/#{id}/records/#{record_id}").body.dig("record")
    end

    def create_record(id, **attributes)
      Object.new post_request("domains/#{id}/records", body: attributes).body.dig("record")
    end

    def update_record(id, record_id:, **attributes)
      patch_request("domains/#{id}/records/#{record_id}", body: attributes)
    end

    def delete_record(id, record_id:)
      delete_request("domains/#{id}/records/#{record_id}")
    end
  end
end

