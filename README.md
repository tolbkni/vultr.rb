# VULTR Rubygem

The easiest and most complete rubygem for [VULTR](https://www.vultr.com).

```ruby
Vultr.api_key = "your_api_key"
r = Vultr::Server.list
# => {
#    :status=>200,
#    :result=>[40, 11, 45, 29, 41, 61, 46, 35, 12, 30, 42, 3, 39, 13, 60, 36, 37, 43, 27, 28, 38]
# }

r[:status]
r[:result]
```

You can find your keys at [https://my.vultr.com/settings/#API](https://my.vultr.com/settings/#API)

## Installation

Add this line to your application's Gemfile:

    gem 'vultr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vultr

## Usage

### List Servers

```ruby
Vultr::Server.list
```

### Create Server

```ruby
Vultr::Server.create({DCID: dc_id, VPSPLANID: vps_plan_id, OSID: os_id})
```

## Available Commands

```ruby
Vultr::Account.info

Vultr::App.list

Vultr::Backup.list

Vultr::DNS.list
Vultr::DNS.create_domain({domain: domain, serverip: server_ip})
Vultr::DNS.delete_domain(domain: domain)
Vultr::DNS.records(domain: domain)
Vultr::DNS.create_record({domain: domain, name: name, type: type, data: data, ttl: ttl, priority: priority})
Vultr::DNS.delete_record({domain: domain, RECORDID: record_id})

Vultr::ISO.list

Vultr::OS.list

Vultr::Plan.list

Vultr::Region.list
Vultr::Region.availability(DCID: dc_id)

Vultr::Server.list
Vultr::Server.start(SUBID: sub_id)
Vultr::Server.halt(SUBID: sub_id)
Vultr::Server.reboot(SUBID: sub_id)
Vultr::Server.create({DCID: dc_id, VPSPLANID: vps_plan_id, OSID: os_id, ipxe_chain_url: ipxe_chain_url, SCRIPTID: script_id, SNAPSHOTID: snapshot_id})
Vultr::Server.destroy(SUBID: sub_id)
Vultr::Server.label_set({SUBID: sub_id, label: label})
Vultr::Server.os_change_list(SUBID: sub_id)
Vultr::Server.os_change({SUBID: sub_id, OSID: os_id})
Vultr::Server.reinstall(SUBID: sub_id)
Vultr::Server.upgrade_plan_list(SUBID: sub_id)
Vultr::Server.upgrade_plan({SUBID: sub_id, VPSPLANID: vpsplan_id})
Vultr::Server.restore_backup({SUBID: sub_id, BACKUPID: backup_id})
Vultr::Server.restore_snapshot({SUBID: sub_id, SNAPSHOTID: snapshot_id})
Vultr::Server.list_ipv4(SUBID: sub_id)
Vultr::Server.create_ipv4（{SUBID: sub_id, reboot: reboot})
Vultr::Server.destroy_ipv4({SUBID: sub_id, ip: ip})
Vultr::Server.list_ipv6(SUBID: sub_id)
Vultr::Server.reverse_default_ipv4({SUBID: sub_id, ip: ip})
Vultr::Server.reverse_delete_ipv6(SUBID: sub_id)
Vultr::Server.reverse_list_ipv6(SUBID: sub_id)
Vultr::Server.reverse_set_ipv4({SUBID: sub_id, ip: ip})
Vultr::Server.reverse_set_ipv6({SUBID: sub_id, ip: ip})

Vultr::Snapshot.list
Vultr::Snapshot.create(SUBID: sub_id)
Vultr::Snapshot.destroy(SNAPSHOTID: snapshot_id)

Vultr::SSHKey.list
Vultr::SSHKey.create({name: name, ssh_key: ssh_key})
Vultr::SSHKey.destroy(SSHKEYID: sshkey_id)
Vultr::SSHKey.update({SSHKEYID: sshkey_id, name: name, ssh_key: ssh_key})

Vultr::StartupScript.list
Vultr::StartupScript.create({name: name, script: script, type: type})
Vultr::StartupScript.destroy(SCRIPTID: script_id)
Vultr::StartupScript.update({SCRIPTID: script_id, name: name, script: script})
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
