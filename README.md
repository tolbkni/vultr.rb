# VULTR Rubygem

[![Build Status](https://img.shields.io/travis/tolbkni/vultr.rb.svg)](https://travis-ci.org/tolbkni/vultr.rb)
[![Gem Version](https://badge.fury.io/rb/vultr.svg)](https://badge.fury.io/rb/vultr)


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

Vultr::Auth.info

Vultr::Backup.list

Vultr::Block.attach({SUBID: sub_id, attach_to_SUBID: attach_to_sub_id})
Vultr::Block.create({DCID: dc_id, size_gb: size_gb, label: label})
Vultr::Block.delete(SUBID: sub_id)
Vultr::Block.detach(SUBID: sub_id)
Vultr::Block.label_set({SUBID: sub_id, label: label})
Vultr::Block.list(SUBID: sub_id)
Vultr::Block.resize({SUBID: sub_id, size_gb: size_gb})

Vultr::DNS.create_domain({domain: domain, serverip: server_ip})
Vultr::DNS.create_record({domain: domain, name: name, type: type, data: data, ttl: ttl, priority: priority})
Vultr::DNS.delete_domain(domain: domain)
Vultr::DNS.delete_record({domain: domain, RECORDID: record_id})
Vultr::DNS.list
Vultr::DNS.records(domain: domain)
Vultr::DNS.update_record({domain: domain, RECORDID: record_id, name: name, type: type, data: data, ttl: ttl, priority: priority})

Vultr::ISO.list

Vultr::OS.list

Vultr::Plans.list
Vultr::Plans.list_vc2
Vultr::Plans.list_vdc2

Vultr::Regions.list
Vultr::Regions.availability(DCID: dc_id)

Vultr::ReservedIP.attach({ip_address: ip_address, attach_SUBID: attach_sub_id})
Vultr::ReservedIP.convert({SUBID: sub_id, ip_address: ip_address, label: label})
Vultr::ReservedIP.create({DCID: dc_id, ip_type: ip_type, label: label})
Vultr::ReservedIP.destroy(ip_address: ip_address)
Vultr::ReservedIP.detach({ip_address: ip_address, detach_SUBID: detach_sub_id})
Vultr::ReservedIP.list

Vultr::Server.app_change({SUBID: sub_id, APPID: app_id})
Vultr::Server.app_change_list(SUBID: sub_id)
Vultr::Server.backup_disable(SUBID: sub_id)
Vultr::Server.backup_enable(SUBID: sub_id)
Vultr::Server.backup_get_schedule(SUBID: sub_id)
Vultr::Server.backup_set_schedule({SUBID: sub_id, cron_type: cron_type, hour: hour, dow: dow, dom: dom})
Vultr::Server.bandwidth(SUBID: sub_id)
Vultr::Server.create({DCID: dc_id, VPSPLANID: vps_plan_id, OSID: os_id, ipxe_chain_url: ipxe_chain_url, ISOID: iso_id,
                      SCRIPTID: script_id, SNAPSHOTID: snapshot_id, enable_ipv6: enable_ipv6, enable_private_network: enable_private_network,
                      private_network: private_network, label: label, SSHKEYID: sshkey_id, auto_backups: auto_backups, APPID: app_id,
                      userdata: userdata, notify_activate: notify_activate, ddos_protection: ddos_protection, reserved_ip_v4: reserved_ipv4,
                      hostname: hostname, tag: tag})
Vultr::Server.create_ipv4（{SUBID: sub_id, reboot: reboot})
Vultr::Server.destroy(SUBID: sub_id)
Vultr::Server.destroy_ipv4({SUBID: sub_id, ip: ip})
Vultr::Server.get_app_inf(SUBID: sub_id)
Vultr::Server.get_user_data(SUBID: sub_id)
Vultr::Server.halt(SUBID: sub_id)
Vultr::Server.iso_attach({SUBID: sub_id, ISOID: iso_id})
Vultr::Server.iso_detach(SUBID: sub_id)
Vultr::Server.iso_status(SUBID: sub_id)
Vultr::Server.label_set({SUBID: sub_id, label: label})
Vultr::Server.list({SUBID: sub_id, tag: tag})
Vultr::Server.list_ipv4(SUBID: sub_id)
Vultr::Server.list_ipv6(SUBID: sub_id)
Vultr::Server.neighbors(SUBID: sub_id)
Vultr::Server.os_change({SUBID: sub_id, OSID: os_id})
Vultr::Server.os_change_list(SUBID: sub_id)
Vultr::Server.reboot(SUBID: sub_id)
Vultr::Server.reinstall({SUBID: sub_id, hostname: hostname})
Vultr::Server.restore_backup({SUBID: sub_id, BACKUPID: backup_id})
Vultr::Server.restore_snapshot({SUBID: sub_id, SNAPSHOTID: snapshot_id})
Vultr::Server.reverse_default_ipv4({SUBID: sub_id, ip: ip})
Vultr::Server.reverse_delete_ipv6({SUBID: sub_id, ip: ip})
Vultr::Server.reverse_list_ipv6(SUBID: sub_id)
Vultr::Server.reverse_set_ipv4({SUBID: sub_id, ip: ip, entry: entry})
Vultr::Server.reverse_set_ipv6({SUBID: sub_id, ip: ip, entry: entry})
Vultr::Server.set_user_data({SUBID: sub_id, userdata: userdata})
Vultr::Server.start(SUBID: sub_id)
Vultr::Server.upgrade_plan({SUBID: sub_id, VPSPLANID: vpsplan_id})
Vultr::Server.upgrade_plan_list(SUBID: sub_id)

Vultr::Snapshot.create(SUBID: sub_id)
Vultr::Snapshot.destroy(SNAPSHOTID: snapshot_id)
Vultr::Snapshot.list

Vultr::SSHKey.create({name: name, ssh_key: ssh_key})
Vultr::SSHKey.destroy(SSHKEYID: sshkey_id)
Vultr::SSHKey.list
Vultr::SSHKey.update({SSHKEYID: sshkey_id, name: name, ssh_key: ssh_key})

Vultr::StartupScript.create({name: name, script: script, type: type})
Vultr::StartupScript.destroy(SCRIPTID: script_id)
Vultr::StartupScript.list
Vultr::StartupScript.update({SCRIPTID: script_id, name: name, script: script})

Vultr::User.create({email: email, name: name, password: password, api_enabled: api_enabled, acls: acls})
Vultr::User.delete(USERID: user_id)
Vultr::User.list
Vultr::User.update({USERID: user_id, email: email, name: name, password: password, api_enabled: api_enabled, acls: acls})
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
