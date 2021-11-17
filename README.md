# Vultr API Rubygem

[![Build Status](https://github.com/tolbkni/vultr.rb/workflows/Tests/badge.svg)](https://github.com/tolbkni/vultr.rb/actions)

The easiest and most complete rubygem for [Vultr](https://www.vultr.com). Currently supports [API v2](https://www.vultr.com/api/v2).

## Installation

Add this line to your application's Gemfile:

    gem 'vultr', github: "excid3/vultr.rb"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vultr

## Usage

To access the API, you'll need to create a `Vultr::Client` and pass in your API key. You can find your API key at [https://my.vultr.com/settings](https://my.vultr.com/settings/#settingsapi)

```ruby
client = Vultr::Client.new(api_key: ENV["VULTR_API_KEY"])
```

The client then gives you access to each of the resources.

## Resources

The gem maps as closely as we can to the Vultr API so you can easily convert API examples to gem code.

Responses are created as objects like `Vultr::Account`. Having types like `Vultr::User` is handy for understanding what type of object you're working with. They're built using OpenStruct so you can easily access data in a Ruby-ish way.

##### Pagination

 `list` endpoints return pages of results. The result object will have a `data` key to access the results, as well as metadata like `next_cursor` and `prev_cursor` for retrieving the next and previous pages. You may also specify the

```ruby
results = client.applications.list(per_page: 5)
#=> Vultr::Collection

results.total
#=> 48

results.data
#=> [#<Vultr::Application>, #<Vultr::Application>]

results.next_cursor
#=> "bmV4dF9fMTU="

# Retrieve the next page
client.applications.list(per_page: 5, cursor: results.next_cursor)
#=> Vultr::Collection
```

### Account

```ruby
client.account.info
```

### Applications

```ruby
client.applications.list
```

### Backups

```ruby
client.backups.list
client.backups.get(backup_id: "id")
```

### Bare Metal

```ruby
client.bare_metal.list
client.bare_metal.create({})
client.bare_metal.retrieve(baremetal_id: "id")
client.bare_metal.update(baremetal_id: "id", {})
client.bare_metal.delete(baremetal_id: "id")
client.bare_metal.start(baremetal_id: "id")
client.bare_metal.reboot(baremetal_id: "id")
client.bare_metal.reinstall(baremetal_id: "id")
client.bare_metal.halt(baremetal_id: "id")
client.bare_metal.bandwidth(baremetal_id: "id")
client.bare_metal.user_data(baremetal_id: "id")
client.bare_metal.upgrades(baremetal_id: "id")
client.bare_metal.vnc(baremetal_id: "id")
client.bare_metal.list_ipv4(baremetal_id: "id")
client.bare_metal.list_ipv6(baremetal_id: "id")

# Bulk operations
client.bare_metal.start_instances(baremetal_ids: [id1, id2])
client.bare_metal.halt_instances(baremetal_ids: [id1, id2])
client.bare_metal.reboot_instances(baremetal_ids: [id1, id2])
```

### Block Storage

```ruby
client.block_storage.list
client.block_storage.create({})
client.block_storage.retrieve(block_id: "id")
client.block_storage.update(block_id: "id", {})
client.block_storage.delete(block_id: "id")
client.block_storage.attach(block_id: "id", {})
client.block_storage.detach(block_id: "id")
```

### DNS (Domains)

```ruby
client.dns.list
client.dns.create({})
client.dns.retrieve(dns_domain: "id")
client.dns.update(dns_domain: "id", {})
client.dns.delete(dns_domain: "id")
client.dns.soa(dns_domain: "id")
client.dns.update_soa(dns_domain: "id", {})
client.dns.dnssec(dns_domain: "id")
client.dns.list_records(dns_domain: "id")
client.dns.retrieve_record(dns_domain: "id", record_id: "id")
client.dns.create_record(dns_domain: "id", {})
client.dns.update_record(dns_domain: "id", record_id: "id", {})
client.dns.delete_record(dns_domain: "id", record_id: "id")
```

### Firewall

```ruby
client.firewall.list
client.firewall.create({})
client.firewall.retrieve(firewall_group_id: "id")
client.firewall.update(firewall_group_id: "id", {})
client.firewall.delete(firewall_group_id: "id")
client.firewall.list_rules(firewall_group_id: "id")
client.firewall.create_rule(firewall_group_id: "id", {})
client.firewall.retrieve_rule(firewall_group_id: "id", firewall_rule_id: "id")
client.firewall.delete_rule(firewall_group_id: "id", firewall_rule_id: "id")
```

### Instances

```ruby
client.instances.list
client.instances.create({})
client.instances.retrieve(instance_id: "id")
client.instances.update(instance_id: "id", {})
client.instances.delete(instance_id: "id")
client.instances.start(instance_id: "id")
client.instances.reboot(instance_id: "id")
client.instances.reinstall(instance_id: "id")
client.instances.restore(instance_id: "id", {})
client.instances.halt(instance_id: "id")
client.instances.bandwidth(instance_id: "id")
client.instances.neighbors(instance_id: "id")
client.instances.user_data(instance_id: "id")
client.instances.upgrades(instance_id: "id")
client.instances.list_ipv4(instance_id: "id")
client.instances.create_ipv4(instance_id: "id", {})
client.instances.delete_ipv4(instance_id: "id", ipv4: "id")
client.instances.create_ipv4_reverse(instance_id: "id", {})
client.instances.set_default_reverse_dns_entry(instance_id: "id", {})
client.instances.list_ipv6(instance_id: "id")
client.instances.ipv6_reverse(instance_id: "id")
client.instances.create_ipv6_reverse(instance_id: "id", {})
client.instances.delete_ipv6_reverse(instance_id: "id", ipv6: "id")
client.instances.list_private_networks(instance_id: "id")
client.instances.attach_private_network(instance_id: "id", network_id: "id")
client.instances.detach_private_network(instance_id: "id", network_id: "id")
client.instances.iso(instance_id: "id")
client.instances.attach_iso(instance_id: "id", iso_id: "id")
client.instances.detach_iso(instance_id: "id", iso_id: "id")
client.instances.backup_schedule(instance_id: "id")
client.instances.set_backup_schedule(instance_id: "id", {})

# Bulk operations
client.instances.start_instances(instance_ids: [id1, id2])
client.instances.halt_instances(instance_ids: [id1, id2])
client.instances.reboot_instances(instance_ids: [id1, id2])
```

### ISO

```ruby
client.iso.list
client.iso.create({})
client.iso.retrieve(iso_id: "id")
client.iso.delete(iso_id: "id")
client.iso.list_public
```

### Kubernetes

```ruby
client.kubernetes.list
client.kubernetes.create({})
client.kubernetes.retrieve(vke_id: "id")
client.kubernetes.update(vke_id: "id", {})
client.kubernetes.delete(vke_id: "id")
client.kubernetes.config(vke_id: "id")
client.kubernetes.list_resources(vke_id: "id")
client.kubernetes.list_node_pools(vke_id: "id")
client.kubernetes.retrieve_node_pool(vke_id: "id", nodepool_id: "id")
client.kubernetes.create_node_pool(vke_id: "id", {})
client.kubernetes.update_node_pool(vke_id: "id", nodepool_id: "id", {})
client.kubernetes.delete_node_pool(vke_id: "id", nodepool_id: "id")
client.kubernetes.delete_node_pool_instance(vke_id: "id", nodepool_id: "id", node_id: "id")
client.kubernetes.recycle_node_pool_instance(vke_id: "id", nodepool_id: "id", node_id: "id")
```

### Load Balancers

```ruby
client.load_balancers.list
client.load_balancers.create({})
client.load_balancers.retrieve(load_balancer_id: "id")
client.load_balancers.update(load_balancer_id: "id", {})
client.load_balancers.delete(load_balancer_id: "id")
client.load_balancers.list_forwarding_rules(load_balancer_id: "id")
client.load_balancers.create_forwarding_rule(load_balancer_id: "id", {})
client.load_balancers.retrieve_forwarding_rule(load_balancer_id: "id", forwarding_rule_id: "id")
client.load_balancers.delete_forwarding_rule(load_balancer_id: "id", forwarding_rule_id: "id")
client.load_balancers.list_firewall_rules(load_balancer_id: "id")
client.load_balancers.retrieve_firewall_rule(load_balancer_id: "id", firewall_rule_id: "id")
```

### Object Storage

```ruby
client.object_storage.list
client.object_storage.create({})
client.object_storage.retrieve(object_storage_id: "id")
client.object_storage.update(object_storage_id: "id", {})
client.object_storage.delete(object_storage_id: "id")
client.object_storage.regenerate_keys(object_storage_id: "id")
client.object_storage.list_clusters()
```

### Operating Systems

```ruby
client.operating_systems.list
```

### Plans

```ruby
client.plans.list
client.plans.list_metal
```

### Private Networks

```ruby
client.private_networks.list
client.private_networks.create({})
client.private_networks.retrieve(network_id: "id")
client.private_networks.update(network_id: "id", {})
client.private_networks.delete(network_id: "id")
```

### Regions

```ruby
client.regions.list
client.regions.list_availability(region_id: "id")
```

### Reserved IPs

```ruby
client.reserved_ips.list
client.reserved_ips.create({})
client.reserved_ips.retrieve(reserved_ip: "id")
client.reserved_ips.delete(reserved_ip: "id")
client.reserved_ips.attach(reserved_ip: "id", instance_id: "id")
client.reserved_ips.detach(reserved_ip: "id")
client.reserved_ips.convert({})
```

### Snapshots

```ruby
client.snapshots.list
client.snapshots.create({})
client.snapshots.retrieve(snapshot_id: "id")
client.snapshots.create_from_url("https://...")
client.snapshots.update(snapshot_id: "id", {})
client.snapshots.delete(snapshot_id: "id")
```

### SSH Keys

```ruby
client.ssh_keys.list
client.ssh_keys.create({})
client.ssh_keys.retrieve(ssh_key_id: "id")
client.ssh_keys.update(ssh_key_id: "id", {})
client.ssh_keys.delete(ssh_key_id: "id")
```

### Startup Scripts

```ruby
client.startup_scripts.list
client.startup_scripts.create({})
client.startup_scripts.retrieve(startup_script_id: "id")
client.startup_scripts.update(startup_script_id: "id", {})
client.startup_scripts.delete(startup_script_id: "id")
```

### Users

```ruby
client.users.list
client.users.create({})
client.users.retrieve(user_id: "id")
client.users.update(user_id: "id", {})
client.users.delete(user_id: "id")
```

## Contributing

1. Fork it ( https://github.com/tolbkni/vultr/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

When adding methods, add to the list of DEFINITIONS in lib/vultr.rb. Additionally, write a spec and add it to the list in the README.

## Thanks

Thanks Scott Motte and his [DigitalOcean](https://github.com/scottmotte/digitalocean) rubygem project.
