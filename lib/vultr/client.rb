module Vultr
  class Client
    BASE_URL = "https://api.vultr.com/v2"

    attr_reader :api_key, :adapter

    def initialize(api_key: Vultr.api_key, adapter: Faraday.default_adapter)
      #raise Error, "Please set Vultr.api_key = 'xxx' to make a request" unless api_key
      @api_key = api_key
      @adapter = adapter
    end

    def account
      AccountResource.new(self)
    end

    def applications
      ApplicationsResource.new(self)
    end

    def backups
      BackupResource.new(self)
    end

    def instances
      InstancesResource.new(self)
    end

    def users
      UserResource.new(self)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.adapter adapter
      end
    end
  end
end
