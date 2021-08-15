# VULTR Rubygem

[![Build Status](https://img.shields.io/travis/tolbkni/vultr.rb.svg)](https://travis-ci.org/tolbkni/vultr.rb)
[![Gem Version](https://badge.fury.io/rb/vultr.svg)](https://badge.fury.io/rb/vultr)

The easiest and most complete rubygem for [VULTR](https://www.vultr.com) [API v2](https://www.vultr.com/api/v2).

## Installation

Add this line to your application's Gemfile:

    gem 'vultr'

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
client.backups.get("id")
```

### Bare Metal

```ruby
client.bare_metal.list
client.bare_metal.retrieve("id")
client.bare_metal.create({})
client.bare_metal.update(id, {})
client.bare_metal.delete(id)
client.bare_metal.start(id)
client.bare_metal.reboot(id)
client.bare_metal.reinstall(id)
client.bare_metal.halt(id)
client.bare_metal.bandwidth(id)
client.bare_metal.user_data(id)
client.bare_metal.upgrades(id)
client.bare_metal.vnc(id)
client.bare_metal.list_ipv4(id)
client.bare_metal.list_ipv6(id)

# Bulk operations
client.bare_metal.start_instances([id1, id2])
client.bare_metal.halt_instances([id1, id2])
client.bare_metal.reboot_instances([id1, id2])
```

### Block Storage

```ruby
client.block_storage.list
client.block_storage.retrieve(id)
client.block_storage.create({})
client.block_storage.update(id, {})
client.block_storage.delete(id)
client.block_storage.attach(id, {})
client.block_storage.detach(id)
```

### DNS (Domains)

```ruby
client.dns.list
client.dns.retrieve(id)
client.dns.create({})
client.dns.update(id, {})
client.dns.delete(id)
client.dns.soa(id)
client.dns.update_soa(id, {})
client.dns.dnssec(id)
client.dns.list_records(id)
client.dns.retrieve_record(id, record_id: "id")
client.dns.create_record(id, {})
client.dns.update_record(id, record_id: "id", {})
client.dns.delete_record(id, record_id: "id")
```

### Firewall

```ruby
client.firewall.list
client.firewall.retrieve(id)
client.firewall.create({})
client.firewall.update(id, {})
client.firewall.delete(id)
client.firewall.list_rules(id)
client.firewall.retrieve_rule(id, rule_id: "id")
client.firewall.create_rule(id, {})
client.firewall.delete_rule(id, rule_id: "id")
```

### Instances

```ruby
client.instances.list
client.instances.retrieve("id")
client.instances.create({})
client.instances.update(id, {})
client.instances.delete(id)
client.instances.start(id)
client.instances.reboot(id)
client.instances.reinstall(id)
client.instances.restore(id, {})
client.instances.halt(id)
client.instances.bandwidth(id)
client.instances.neighbors(id)
client.instances.user_data(id)
client.instances.upgrades(id)
client.instances.list_ipv4(id)
client.instances.create_ipv4(id, {})
client.instances.delete_ipv4(id, ipv4: "id")
client.instances.create_ipv4_reverse(id, {})
client.instances.set_default_reverse_dns_entry(id, {})
client.instances.list_ipv6(id)
client.instances.ipv6_reverse(id)
client.instances.create_ipv6_reverse(id, {})
client.instances.delete_ipv6_reverse(id, ipv6: "id")
client.instances.list_private_networks(id)
client.instances.attach_private_network(id, network_id: "id")
client.instances.detach_private_network(id, network_id: "id")
client.instances.iso(id)
client.instances.attach_iso(id, iso_id: "id")
client.instances.detach_iso(id, iso_id: "id")
client.instances.backup_schedule(id)
client.instances.set_backup_schedule(id, {})

# Bulk operations
client.instances.start_instances([id1, id2])
client.instances.halt_instances([id1, id2])
client.instances.reboot_instances([id1, id2])
```

### ISO

```ruby
client.iso.list
client.iso.retrieve(id)
client.iso.create({})
client.iso.delete(id)
client.iso.list_public
```

### Kubernetes

```ruby
client.kubernetes.list
client.kubernetes.retrieve(id)
client.kubernetes.create({})
client.kubernetes.update(id, {})
client.kubernetes.delete(id)
client.kubernetes.config(id)
client.kubernetes.list_resources(id)
client.kubernetes.list_node_pools(id)
client.kubernetes.retrieve_node_pool(id, nodepool_id: "id")
client.kubernetes.create_node_pool(id, {})
client.kubernetes.update_node_pool(id, nodepool_id: "id", {})
client.kubernetes.delete_node_pool(id, nodepool_id: "id")
client.kubernetes.delete_node_pool_instance(id, nodepool_id: "id", node_id: "id")
client.kubernetes.recycle_node_pool_instance(id, nodepool_id: "id", node_id: "id")
```

### Load Balancers

```ruby
client.load_balancers.list
client.load_balancers.retrieve(id)
client.load_balancers.create({})
client.load_balancers.update(id, {})
client.load_balancers.delete(id)
client.load_balancers.list_forwarding_rules(id)
client.load_balancers.retrieve_forwarding_rule(id, rule_id: "id")
client.load_balancers.create_forwarding_rule(id, {})
client.load_balancers.delete_forwarding_rule(id, rule_id: "id")
client.load_balancers.list_firewall_rules(id)
client.load_balancers.retrieve_firewall_rule(id)
```

### Object Storage

```ruby
client.object_storage.list
client.object_storage.retrieve(id)
client.object_storage.create({})
client.object_storage.update(id, {})
client.object_storage.delete(id)
client.object_storage.regenerate_keys(id)
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
client.private_networks.retrieve(id)
client.private_networks.create({})
client.private_networks.update(id, {})
client.private_networks.delete(id)
```

### Regions

```ruby
client.regions.list
client.regions.list_availability("region_id")
```

### Reserved IPs

```ruby
client.reserved_ips.list
client.reserved_ips.retrieve(id)
client.reserved_ips.create({})
client.reserved_ips.delete(id)
client.reserved_ips.attach(id, reserved_ip: "")
client.reserved_ips.detach(id)
client.reserved_ips.convert({})
```

### Snapshots

```ruby
client.snapshots.list
client.snapshots.retrieve(id)
client.snapshots.create({})
client.snapshots.create_from_url("https://...")
client.snapshots.update(id, {})
client.snapshots.delete(id)
```

### SSH Keys

```ruby
client.ssh_keys.list
client.ssh_keys.retrieve(id)
client.ssh_keys.create({})
client.ssh_keys.update(id, {})
client.ssh_keys.delete(id)
```

### Startup Scripts

```ruby
client.startup_scripts.list
client.startup_scripts.retrieve(id)
client.startup_scripts.create({})
client.startup_scripts.update(id, {})
client.startup_scripts.delete(id)
```

### Users

```ruby
client.users.list
client.users.retrieve(id)
client.users.create({})
client.users.update(id, {})
client.users.delete(id)
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
