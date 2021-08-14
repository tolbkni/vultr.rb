require 'faraday'
require 'faraday_middleware'
require 'vultr/version'

module Vultr
  autoload :Client, "vultr/client"
  autoload :Collection, "vultr/collection"
  autoload :Error, "vultr/error"
  autoload :Resource, "vultr/resource"
  autoload :Object, "vultr/object"

  autoload :AccountResource, "vultr/resources/account"
  autoload :ApplicationsResource, "vultr/resources/applications"
  autoload :InstancesResource, "vultr/resources/instances"
  autoload :BackupsResource, "vultr/resources/backups"
  autoload :BareMetalResource, "vultr/resources/bare_metal"
  autoload :BlockStorageResource, "vultr/resources/block_storage"
  autoload :DnsResource, "vultr/resources/dns"
  autoload :FirewallResource, "vultr/resources/firewall"
  autoload :IsoResource, "vultr/resources/iso"
  autoload :KubernetesResource, "vultr/resources/kubernetes"
  autoload :LoadBalancersResource, "vultr/resources/load_balancers"
  autoload :ObjectStorageResource, "vultr/resources/object_storage"
  autoload :OperatingSystemsResource, "vultr/resources/operating_systems"
  autoload :PlansResource, "vultr/resources/plans"
  autoload :PrivateNetworksResource, "vultr/resources/private_networks"
  autoload :RegionsResource, "vultr/resources/regions"
  autoload :ReservedIpsResource, "vultr/resources/reserved_ips"
  autoload :SnapshotsResource, "vultr/resources/snapshots"
  autoload :SshKeysResource, "vultr/resources/ssh_keys"
  autoload :StartupScriptsResource, "vultr/resources/startup_scripts"
  autoload :UserResource, "vultr/resources/users"

  autoload :Account, "vultr/objects/account"
  autoload :Application, "vultr/objects/application"
  autoload :Instance, "vultr/objects/instance"
  autoload :User, "vultr/objects/user"

  def self.api_key=(key)
    @api_key = key
  end

  def self.api_key
    @api_key
  end
end
