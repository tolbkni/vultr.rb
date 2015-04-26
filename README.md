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
Vultr::Snapshot.list
Vultr::Snapshot.destroy(SNAPSHOTID: snapshot_id)
Vultr::Snapshot.create(SUBID: sub_id)

Vultr::Plan.list

Vultr::Region.list
Vultr::Region.availability(DCID: dc_id)

Vultr::StartupScript.list
Vultr::StartupScript.destroy(SCRIPTID: script_id)
Vultr::StartupScript.create({name: name, script: script})

Vultr::Server.list
Vultr::Server.reboot(SUBID: sub_id)
Vultr::Server.halt(SUBID: sub_id)
Vultr::Server.start(SUBID: sub_id)
Vultr::Server.destroy(SUBID: sub_id)
Vultr::Server.create({DCID: dc_id, VPSPLANID: vps_plan_id, OSID: os_id,
        ipxe_chain_url: ipxe_chain_url, SCRIPTID: script_id, SNAPSHOTID: snapshot_id})

Vultr::OS.list
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
