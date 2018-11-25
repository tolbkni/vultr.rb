require 'faraday'
require 'faraday_middleware'
require 'vultr/version'

module Vultr extend self

    DEFINITIONS = {
        # Account
        Account: {
            info: {
                :method => :get,
                :path => '/v1/account/info',
                :apikey_required => true
            }
        },
        # Application
        App: {
            list: {
                :method => :get,
                :path => '/v1/app/list',
                :apikey_required => false
            }
        },
        # API Key
        Auth: {
            info: {
                :method => :get,
                :path => '/v1/auth/info',
                :apikey_required => true
            }
        },
        # Backup
        Backup: {
            list: {
                :method => :get,
                :path => '/v1/backup/list',
                :params => %w(SUBID BACKUPID),
                :apikey_required => true
            }
        },
        # Bare Metal
        BareMetal: {
            app_change: {
                :method => :post,
                :path => '/v1/baremetal/app_change',
                :params => %w(SUBID APPID),
                :apikey_required => true
            },
            app_change_list: {
                :method => :get,
                :path => '/v1/baremetal/app_change_list',
                :params => %w(SUBID),
                :apikey_required => true
            },
            bandwidth: {
                :method => :get,
                :path => '/v1/baremetal/bandwidth',
                :apikey_required => true
            },
            create: {
                :method => :post,
                :path => '/v1/baremetal/create',
                :params => %w(DCID METALPLANID OSID SCRIPTID SNAPSHOTID enable_ipv6 label SSHKEYID APPID userdata notify_activate hostname tag),
                :apikey_required => true
            },
            destroy: {
                :method => :post,
                :path => '/v1/baremetal/destroy',
                :params => %w(SUBID),
                :apikey_required => true
            },
            get_app_info: {
                :method => :get,
                :path => '/v1/baremetal/get_app_info',
                :params => %w(SUBID),
                :apikey_required => true
            },
            get_user_data: {
                :method => :get,
                :path => '/v1/baremetal/get_user_data',
                :params => %w(SUBID),
                :apikey_required => true
            },
            halt: {
                :method => :post,
                :path => '/v1/baremetal/halt',
                :params => %w(SUBID),
                :apikey_required => true
            },
            ipv6_enable: {
                :method => :post,
                :path => '/v1/baremetal/ipv6_enable',
                :params => %w(SUBID),
                :apikey_required => true
            },
            label_set: {
                :method => :post,
                :path => '/v1/baremetal/label_set',
                :params => %w(SUBID label),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/baremetal/list',
                :params => %w(SUBID tag label main_ip),
                :apikey_required => true
            },
            list_ipv4: {
                :method => :get,
                :path => '/v1/baremetal/list_ipv4',
                :params => %w(SUBID),
                :apikey_required => true
            },
            list_ipv6: {
                :method => :get,
                :path => '/v1/baremetal/list_ipv6',
                :params => %w(SUBID),
                :apikey_required => true
            },
            os_change: {
                :method => :post,
                :path => '/v1/baremetal/os_change',
                :params => %w(SUBID OSID),
                :apikey_required => true
            },
            os_change_list: {
                :method => :get,
                :path => '/v1/baremetal/os_change_list',
                :params => %w(SUBID),
                :apikey_required => true
            },
            reboot: {
                :method => :post,
                :path => '/v1/baremetal/reboot',
                :params => %w(SUBID),
                :apikey_required => true
            },
            reinstall: {
                :method => :post,
                :path => '/v1/baremetal/reinstall',
                :params => %w(SUBID),
                :apikey_required => true
            },
            set_user_data: {
                :method => :post,
                :path => '/v1/baremetal/set_user_data',
                :params => %w(SUBID userdata),
                :apikey_required => true
            },
            tag_set: {
                :method => :post,
                :path => '/v1/baremetal/tag_set',
                :params => %w(SUBID tag),
                :apikey_required => true
            }
        },
        # Block Storage
        Block: {
            attach: {
                :method => :post,
                :path => '/v1/block/attach?api_key=[api_key]',
                :params => %w(SUBID attach_to_SUBID),
                :apikey_required => true
            },
            create: {
                :method => :post,
                :path => '/v1/block/create',
                :params => %w(DCID size_gb label),
                :apikey_required => true
            },
            delete: {
                :method => :post,
                :path => '/v1/block/delete',
                :params => %w(SUBID),
                :apikey_required => true
            },
            detach: {
                :method => :post,
                :path => '/v1/block/detach',
                :params => %w(SUBID),
                :apikey_required => true
            },
            label_set: {
                :method => :post,
                :path => '/v1/block/label_set',
                :params => %w(SUBID label),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/block/list',
                :params => %w(SUBID),
                :apikey_required => true
            },
            resize: {
                :method => :post,
                :path => '/v1/block/resize',
                :params => %w(SUBID size_gb),
                :apikey_required => true
            }
        },
        # DNS
        DNS: {
            create_domain: {
                :method => :post,
                :path => '/v1/dns/create_domain',
                :params => %w(domain serverip),
                :apikey_required => true
            },
            create_record: {
                :method => :post,
                :path => '/v1/dns/create_record',
                :params => %w(domain name type data ttl priority),
                :apikey_required => true
            },
            delete_domain: {
                :method => :post,
                :path => '/v1/dns/delete_domain',
                :params => %w(domain),
                :apikey_required => true
            },
            delete_record: {
                :method => :post,
                :path => '/v1/dns/delete_record',
                :params => %w(domain RECORDID),
                :apikey_required => true
            },
            dnssec_enable: {
                :method => :post,
                :path => '/v1/dns/dnssec_enable',
                :params => %w(domain enable),
                :apikey_required => true
            },
            dnssec_info: {
                :method => :post,
                :path => '/v1/dns/dnssec_info',
                :params => %w(domain),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/dns/list',
                :apikey_required => true
            },
            records: {
                :method => :get,
                :path => '/v1/dns/records',
                :params => %w(domain),
                :apikey_required => true
            },
            soa_info: {
                :method => :get,
                :path => '/v1/dns/records',
                :params => %w(domain),
                :apikey_required => true
            },
            soa_update: {
                :method => :get,
                :path => '/v1/dns/records',
                :params => %w(domain),
                :apikey_required => true
            },
            update_record: {
                :method => :post,
                :path => '/v1/dns/update_record',
                :params => %w(domain RECORDID name type data ttl priority),
                :apikey_required => true
            }
        },
        # Firewall
        Firewall: {
            group_create: {
                :method => :post,
                :path => '/v1/firewall/group_create',
                :params => %w(description),
                :apikey_required => true
            },
            group_delete: {
                :method => :post,
                :path => '/v1/firewall/group_delete',
                :params => %w(FIREWALLGROUPID),
                :apikey_required => true
            },
            group_list: {
                :method => :get,
                :path => '/v1/firewall/group_list',
                :params => %w(FIREWALLGROUPID),
                :apikey_required => true
            },
            group_set_description: {
                :method => :post,
                :path => '/v1/firewall/group_set_description',
                :params => %w(FIREWALLGROUPID description),
                :apikey_required => true
            },
            rule_create: {
                :method => :post,
                :path => '/v1/firewall/rule_create',
                :params => %w(FIREWALLGROUPID direction ip_type protocol subnet subnet_size port notes),
                :apikey_required => true
            },
            rule_delete: {
                :method => :post,
                :path => '/v1/firewall/rule_delete',
                :params => %w(FIREWALLGROUPID rulenumber),
                :apikey_required => true
            },
            rule_list: {
                :method => :get,
                :path => '/v1/firewall/rule_list',
                :params => %w(FIREWALLGROUPID direction ip_type),
                :apikey_required => true
            }
        },
        # ISO Image
        ISO: {
            create_from_url: {
                :method => :post,
                :path => '/v1/iso/create_from_url',
                :params => %w(url),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/iso/list',
                :apikey_required => true
            },
            list_public: {
                :method => :get,
                :path => '/v1/iso/list_public',
                :apikey_required => true
            }
        },
        # Network
        Network: {
            create: {
                :method => :post,
                :path => '/v1/network/create',
                :params => %w(DCID description v4_subnet v4_subnet_mask),
                :apikey_required => true
            },
            destroy: {
                :method => :post,
                :path => '/v1/network/destroy',
                :params => %w(NETWORKID),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/network/list',
                :apikey_required => true
            }
        },
        # Operating System
        OS: {
            list: {
                :method => :get,
                :path => '/v1/os/list',
                :apikey_required => false
            }
        },
        # Plans
        Plans: {
            list: {
                :method => :get,
                :path => '/v1/plans/list',
                :params => %w(type),
                :apikey_required => true
            },
            list_baremetal: {
                :method => :get,
                :path => '/v1/plans/list_baremetal',
                :apikey_required => true
            },
            list_vc2: {
                :method => :get,
                :path => '/v1/plans/list_vc2',
                :apikey_required => false
            },
            list_vdc2: {
                :method => :get,
                :path => '/v1/plans/list_vdc2',
                :apikey_required => false
            }
        },
        # Regions
        Regions: {
            availability: {
                :method => :get,
                :path => '/v1/regions/availability',
                :params => %w(DCID type),
                :apikey_required => false
            },
            availability_baremetal: {
                :method => :get,
                :path => '/v1/regions/availability_baremetal',
                :params => %w(DCID),
                :apikey_required => true
            },
            availability_vc2: {
                :method => :get,
                :path => '/v1/regions/availability_vc2',
                :params => %w(DCID),
                :apikey_required => false
            },
            availability_vdc2: {
                :method => :get,
                :path => '/v1/regions/availability_vdc2',
                :params => %w(DCID),
                :apikey_required => false
            },
            list: {
                :method => :get,
                :path => '/v1/regions/list',
                :params => %w(availability),
                :apikey_required => false
            }
        },
        # Reserved IP
        ReservedIP: {
            attach: {
                :method => :post,
                :path => '/v1/reservedip/attach',
                :params => %w(ip_address attach_SUBID),
                :apikey_required => true
            },
            convert: {
                :method => :post,
                :path => '/v1/reservedip/convert',
                :params => %w(SUBID ip_address label),
                :apikey_required => true
            },
            create: {
                :method => :post,
                :path => '/v1/reservedip/create',
                :params => %w(DCID ip_type label),
                :apikey_required => true
            },
            destroy: {
                :method => :post,
                :path => '/v1/reservedip/destroy',
                :params => %w(ip_address),
                :apikey_required => true
            },
            detach: {
                :method => :post,
                :path => '/v1/reservedip/detach',
                :params => %w(ip_address detach_SUBID),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/reservedip/list',
                :apikey_required => true
            }
        },
        # Server
        Server: {
            app_change: {
                :method => :post,
                :path => '/v1/server/app_change',
                :params => %w(SUBID APPID),
                :apikey_required => true
            },
            app_change_list: {
                :method => :get,
                :path => '/v1/server/app_change_list',
                :params => ['SUBID'],
                :apikey_required => true
            },
            backup_disable: {
                :method => :post,
                :path => '/v1/server/backup_disable',
                :params => %w(SUBID),
                :apikey_required => true
            },
            backup_enable: {
                :method => :post,
                :path => '/v1/server/backup_enable',
                :params => %w(SUBID),
                :apikey_required => true
            },
            backup_get_schedule: {
                :method => :post,
                :path => '/v1/server/backup_get_schedule',
                :params => %w(SUBID),
                :apikey_required => true
            },
            backup_set_schedule: {
                :method => :post,
                :path => '/v1/server/backup_set_schedule',
                :params => %w(SUBID cron_type hour dow dom),
                :apikey_required => true
            },
            bandwidth: {
                :method => :get,
                :path => '/v1/server/bandwidth',
                :params => %w(SUBID),
                :apikey_required => true
            },
            create: {
                :method => :post,
                :path => '/v1/server/create',
                :params => %w(DCID VPSPLANID OSID ipxe_chain_url ISOID SCRIPTID SNAPSHOTID enable_ipv6 enable_private_network NETWORKID label SSHKEYID auto_backups APPID userdata notify_activate ddos_protection reserved_ip_v4 hostname tag FIREWALLGROUPID),
                :apikey_required => true
            },
            create_ipv4: {
                :method => :post,
                :path => '/v1/server/create_ipv4',
                :params => %w(SUBID reboot),
                :apikey_required => true
            },
            destroy: {
                :method => :post,
                :path => '/v1/server/destroy',
                :params => %w(SUBID),
                :apikey_required => true
            },
            destroy_ipv4: {
                :method => :post,
                :path => '/v1/server/destroy_ipv4',
                :params => %w(SUBID ip),
                :apikey_required => true
            },
            firewall_group_set: {
                :method => :post,
                :path => '/v1/server/firewall_group_set',
                :params => %w(SUBID FIREWALLGROUPID),
                :apikey_required => true
            },
            get_app_info: {
                :method => :get,
                :path => '/v1/server/get_app_info',
                :params => %w(SUBID),
                :apikey_required => true
            },
            get_user_data: {
                :method => :get,
                :path => '/v1/server/set_user_data',
                :params => %w(SUBID),
                :apikey_required => true
            },
            halt: {
                :method => :post,
                :path => '/v1/server/halt',
                :params => %w('SUBID'),
                :apikey_required => true
            },
            ipv6_enable: {
                :method => :post,
                :path => '/v1/server/ipv6_enable',
                :params => %w(SUBID),
                :apikey_required => true
            },
            iso_attach: {
                :method => :post,
                :path => '/v1/server/iso_detach',
                :params => %w(SUBID, ISOID),
                :apikey_required => true
            },
            iso_detach: {
                :method => :post,
                :path => '/v1/server/iso_detach',
                :params => %w(SUBID),
                :apikey_required => true
            },
            iso_status: {
                :method => :get,
                :path => '/v1/server/iso_status',
                :params => %w(SUBID),
                :apikey_required => true
            },
            label_set: {
                :method => :post,
                :path => '/v1/server/label_set',
                :params => %w(SUBID label),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/server/list',
                :params => %w(SUBID tag label main_ip),
                :apikey_required => true
            },
            list_ipv4: {
                :method => :get,
                :path => '/v1/server/list_ipv4',
                :params => %w(SUBID),
                :apikey_required => true
            },
            list_ipv6: {
                :method => :get,
                :path => '/v1/server/list_ipv6',
                :params => %w(SUBID),
                :apikey_required => true
            },
            neighbors: {
                :method => :get,
                :path => '/v1/server/neighbors',
                :params => %w(SUBID),
                :apikey_required => true
            },
            os_change: {
                :method => :post,
                :path => '/v1/server/os_change',
                :params => %w(SUBID OSID),
                :apikey_required => true
            },
            os_change_list: {
                :method => :get,
                :path => '/v1/server/os_change_list',
                :params => %w(SUBID),
                :apikey_required => true
            },
            private_network_disable: {
                :method => :post,
                :path => '/v1/server/private_network_disable',
                :params => %w(SUBID NETWORKID),
                :apikey_required => true
            },
            private_network_enable: {
                :method => :post,
                :path => '/v1/server/private_network_enable',
                :params => %w(SUBID NETWORKID),
                :apikey_required => true
            },
            private_networks: {
                :method => :get,
                :path => '/v1/server/private_networks',
                :params => %w(SUBID),
                :apikey_required => true
            },
            reboot: {
                :method => :post,
                :path => '/v1/server/reboot' 'SUBID',
                :params => %w(SUBID),
                :apikey_required => true
            },
            reinstall: {
                :method => :post,
                :path => '/v1/server/reinstall',
                :params => %w(SUBID hostname),
                :apikey_required => true
            },
            restore_backup: {
                :method => :post,
                :path => '/v1/server/restore_backup',
                :params => %w(SUBID BACKUPID),
                :apikey_required => true
            },
            restore_snapshot: {
                :method => :post,
                :path => '/v1/server/restore_snapshot',
                :params => %w(SUBID SNAPSHOTID),
                :apikey_required => true
            },
            reverse_default_ipv4: {
                :method => :post,
                :path => '/v1/server/reverse_default_ipv4',
                :params => %w(SUBID ip),
                :apikey_required => true
            },
            reverse_delete_ipv6: {
                :method => :post,
                :path => '/v1/server/reverse_delete_ipv6',
                :params => %w(SUBID ip),
                :apikey_required => true
            },
            reverse_list_ipv6: {
                :method => :get,
                :path => '/v1/server/reverse_list_ipv6',
                :params => %w(SUBID),
                :apikey_required => true
            },
            reverse_set_ipv4: {
                :method => :post,
                :path => '/v1/server/reverse_set_ipv4',
                :params => %w(SUBID ip entry),
                :apikey_required => true
            },
            reverse_set_ipv6: {
                :method => :post,
                :path => '/v1/server/reverse_set_ipv6',
                :params => %w(SUBID ip entry),
                :apikey_required => true
            },
            set_user_data: {
                :method => :post,
                :path => '/v1/server/set_user_data',
                :params => %w(SUBID userdata),
                :apikey_required => true
            },
            start: {
                :method => :post,
                :path => '/v1/server/start',
                :params => %w(SUBID),
                :apikey_required => true
            },
            tag_set: {
                :method => :post,
                :path => '/v1/server/tag_set',
                :params => %w(SUBID tag),
                :apikey_required => true
            },
            upgrade_plan: {
                :method => :post,
                :path => '/v1/server/upgrade_plan',
                :params => %w(SUBID VPSPLANID),
                :apikey_required => true
            },
            upgrade_plan_list: {
                :method => :get,
                :path => '/v1/server/upgrade_plan_list',
                :params => %w(SUBID),
                :apikey_required => true
            }
        },
        # Snapshot
        Snapshot: {
            create: {
                :method => :post,
                :path => '/v1/snapshot/create',
                :params => %w(SUBID),
                :apikey_required => true
            },
            destroy: {
                :method => :post,
                :path => '/v1/snapshot/destroy',
                :params => %w(SNAPSHOTID),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/snapshot/list',
                :apikey_required => true
            }
        },
        # SSH Key
        SSHKey: {
            create: {
                :method => :post,
                :path => '/v1/sshkey/create',
                :params => %w(name ssh_key),
                :apikey_required => true
            },
            destroy: {
                :method => :post,
                :path => '/v1/sshkey/destroy',
                :params => %w(SSHKEYID),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/sshkey/list',
                :apikey_required => true
            },
            update: {
                :method => :post,
                :path => '/v1/sshkey/update',
                :params => %w(SSHKEYID name ssh_key)
            }
        },
        # Startup Script
        StartupScript: {
            create: {
                :method => :post,
                :path => '/v1/startupscript/create',
                :params => %w(name script type),
                :apikey_required => true
            },
            destroy: {
                :method => :post,
                :path => '/v1/startupscript/destroy',
                :params => %w(SCRIPTID),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/startupscript/list',
                :apikey_required => true
            },
            update: {
                :method => :post,
                :path => '/v1/startupscript/update',
                :params => %w(SCRIPTID name script),
                :apikey_required => true
            }
        },
        # User Management
        User: {
            create: {
                :method => :post,
                :path => '/v1/user/create',
                :params => %w(email name password api_enabled acls),
                :apikey_required => true
            },
            delete: {
                :method => :post,
                :path => '/v1/user/delete',
                :params => %w(USERID),
                :apikey_required => true
            },
            list: {
                :method => :get,
                :path => '/v1/user/list',
                :apikey_required => true
            },
            update: {
                :method => :post,
                :path => '/v1/user/update',
                :params => %w(USERID email name password api_enabled acls),
                :apikey_required => true
            }
        }
    }

    DEFINITIONS.each do |resource_name, actions|
        resource_class = Class.new(Object) do
            actions.each do |action, config|
                method = config.fetch(:method)
                path = config.fetch(:path)
                params = config.fetch(:params, nil)
                apikey_required = config.fetch(:apikey_required, false)

                define_singleton_method action do |*args|
                    headers = apikey_required ? {'API-Key': Vultr::APIKey} : {}
                    body = nil
                    if method == :get
                        extra_params = Hash.new
                        hash = args[-1]
                        if hash.is_a?(Hash)
                            hash.each do |key, value|
                                extra_params[key] = value if params.include? key.to_s
                            end
                        end
                        url = Vultr.request.build_url(path, extra_params)
                    elsif method == :post
                        body = Hash.new
                        hash = args[-1]
                        if hash.is_a?(Hash)
                            hash.each do |key, value|
                                body[key] = value if params.include? key.to_s
                            end
                        end
                        url = Vultr.request.build_url(path)
                    end

                    resp = Vultr.request.run_request(method, url, body, headers)
                    {status: resp.status, result: resp.body}
                end
            end
        end

        Vultr.const_set(resource_name, resource_class)
    end

    def request=(request)
        @request = request
    end

    def request
        @request
    end

    def api_key=(api_key)
        Vultr.const_set('APIKey', api_key)
        setup_request!

        Vultr::APIKey
    end

    def api_key
        return Vultr::APIKey if Vultr::APIKey
        'API Key is required'
    end

    private

    def setup_request!
        Vultr.request = Faraday.new do |faraday|
            faraday.url_prefix = 'https://api.vultr.com'
            faraday.request :url_encoded
            faraday.response :json, :content_type => 'application/json'
            faraday.adapter :net_http
        end
    end
end
