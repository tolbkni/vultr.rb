module Vultr
  class DnsResource < Resource
    def list(**params)
      response = get_request("domains", params: params)
      Collection.from_response(response, key: "domains", type: Domain)
    end

    def create(**attributes)
      Domain.new post_request("domains", body: attributes).body.dig("domain")
    end

    def retrieve(dns_domain:)
      Domain.new get_request("domains/#{dns_domain}").body.dig("domain")
    end

    def update(dns_domain:, **attributes)
      put_request("domains/#{dns_domain}", body: attributes)
    end

    def delete(dns_domain:)
      delete_request("domains/#{dns_domain}")
    end

    def soa(dns_domain:)
      Object.new get_request("domains/#{dns_domain}/soa").body.dig("dns_soa")
    end

    def update_soa(dns_domain:, **attributes)
      patch_request("domains/#{dns_domain}/soa", body: attributes)
    end

    # Returns an Array of strings
    def dnssec(dns_domain:)
      get_request("domains/#{dns_domain}/dnssec").body.dig("dns_sec")
    end

    def list_records(dns_domain:, **params)
      response = get_request("domains/#{dns_domain}/records", params: params)
      Collection.from_response(response, key: "records", type: Object)
    end

    def create_record(dns_domain:, **attributes)
      Object.new post_request("domains/#{dns_domain}/records", body: attributes).body.dig("record")
    end

    def retrieve_record(dns_domain:, record_id:)
      Object.new get_request("domains/#{dns_domain}/records/#{record_id}").body.dig("record")
    end

    def update_record(dns_domain:, record_id:, **attributes)
      patch_request("domains/#{dns_domain}/records/#{record_id}", body: attributes)
    end

    def delete_record(dns_domain:, record_id:)
      delete_request("domains/#{dns_domain}/records/#{record_id}")
    end
  end
end
