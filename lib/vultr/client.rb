module Vultr
  class Client
    BASE_URL = "https://api.vultr.com/v2"

    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def account
      AccountResource.new(self)
    end

    def applications
      ApplicationsResource.new(self)
    end

    def backups
      BackupsResource.new(self)
    end

    def bare_metal
      BareMetalResource.new(self)
    end

    def block_storage
      BlockStorageResource.new(self)
    end

    def dns
      DnsResource.new(self)
    end

    def firewall
      FirewallResource.new(self)
    end

    def instances
      InstancesResource.new(self)
    end

    def iso
      IsoResource.new(self)
    end

    def kubernetes
      KubernetesResource.new(self)
    end

    def load_balancers
      LoadBalancersResource.new(self)
    end

    def object_storage
      ObjectStorageResource.new(self)
    end

    def operating_systems
      OperatingSystemsResource.new(self)
    end

    def plans
      PlansResource.new(self)
    end

    def private_networks
      PrivateNetworksResource.new(self)
    end

    def reserved_ips
      ReservedIpsResource.new(self)
    end

    def regions
      RegionsResource.new(self)
    end

    def snapshots
      SnapshotsResource.new(self)
    end

    def ssh_keys
      SshKeysResource.new(self)
    end

    def startup_scripts
      StartupScriptsResource.new(self)
    end

    def users
      UserResource.new(self)
    end

    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.request :authorization, :Bearer, api_key
        conn.request :json

        conn.response :dates
        conn.response :json, content_type: "application/json"

        conn.adapter adapter, @stubs
      end
    end
  end
end
