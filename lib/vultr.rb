require 'faraday'
require 'faraday_middleware'
require 'vultr/version'

module Vultr
  extend self

  DEFINITIONS = {
      Account: {
          info: [:get, '/v1/account/info?api_key=[api_key]']
      },
      App: {
          list: [:get, '/v1/app/list']
      },
      Auth: {
          info: [:get, '/v1/auth/info?api_key=[api_key]']
      },
      Backup: {
          list: [:get, '/v1/backup/list?api_key=[api_key]']
      },
      Block: {
          attach: [:post, '/v1/block/attach?api_key=[api_key]', ['SUBID', 'attach_to_SUBID']],
          create: [:post, '/v1/block/create?api_key=[api_key]', ['DCID', 'size_gb', 'label']],
          delete: [:post, '/v1/block/delete?api_key=[api_key]', ['SUBID']],
          detach: [:post, '/v1/block/detach?api_key=[api_key]', ['SUBID']],
          label_set: [:post, '/v1/block/label_set?api_key=[api_key]', ['SUBID', 'label']],
          list: [:get, '/v1/block/list?api_key=[api_key]&SUBID=[SUBID]'],
          resize: [:post, '/v1/block/resize?api_key=[api_key]', ['SUBID', 'size_gb']]
      },
      DNS: {
          create_domain: [:post, '/v1/dns/create_domain?api_key=[api_key]', ['domain', 'serverip']],
          create_record: [:post, '/v1/dns/create_record?api_key=[api_key]', ['domain', 'name', 'type', 'data', 'ttl', 'priority']],
          delete_domain: [:post, '/v1/dns/delete_domain?api_key=[api_key]', ['domain']],
          delete_record: [:post, '/v1/dns/delete_record?api_key=[api_key]', ['domain', 'RECORDID']],
          list: [:get, '/v1/dns/list?api_key=[api_key]'],
          records: [:get, '/v1/dns/records?api_key=[api_key]&domain=[domain]'],
          update_record: [:post, '/v1/dns/update_record?api_key=[api_key]', ['domain', 'RECORDID', 'name', 'type', 'data', 'ttl', 'priority']]
      },
      ISO: {
          list: [:get, '/v1/iso/list?api_key=[api_key]']
      },
      OS: {
          list: [:get, '/v1/os/list']
      },
      Plans: {
          list: [:get, '/v1/plans/list?type=[type]'],
          list_vc2: [:get, '/v1/plans/list_vc2'],
          list_vdc2: [:get, '/v1/plans/list_vdc2']
      },
      Regions: {
          availability: [:get, '/v1/regions/availability?DCID=[DCID]'],
          list: [:get, '/v1/regions/list']
      },
      RevervedIP: {
          attach: [:post, '/v1/reservedip/list?api_key=[api_key]', ['ip_address', 'attach_SUBID']],
          convert: [:post, '/v1/reservedip/list?api_key=[api_key]', ['SUBID', 'ip_address', 'label']],
          create: [:post, '/v1/reservedip/list?api_key=[api_key]', ['DCID', 'ip_type', 'label']],
          destroy: [:post, '/v1/reservedip/list?api_key=[api_key]', ['ip_address']],
          detach: [:post, '/v1/reservedip/list?api_key=[api_key]', ['ip_address', 'detach_SUBID']],
          list: [:get, '/v1/reservedip/list?api_key=[api_key]']
      },
      Server: {
          app_change: [:post, '/v1/server/app_change?api_key=[api_key]', ['SUBID', 'APPID']],
          app_change_list: [:get, '/v1/server/app_change?api_key=[api_key]&SUBID=[SUBID]'],
          backup_disable: [:post, '/v1/server/backup_disable?api_key=[api_key]', ['SUBID']],
          backup_enable: [:post, '/v1/server/backup_enable?api_key=[api_key]', ['SUBID']],
          backup_get_schedule: [:post, '/v1/server/backup_get_schedule?api_key=[api_key]', ['SUBID']],
          backup_set_schedule: [:post, '/v1/server/backup_set_schedule?api_key=[api_key]', ['SUBID', 'cron_type', 'hour', 'dow', 'dom']],
          bandwidth: [:get, '/v1/server/bandwidth?api_key=[api_key]&SUBID=[SUBID]'],
          create: [:post, '/v1/server/create?api_key=[api_key]',
                   ['DCID', 'VPSPLANID', 'OSID', 'ipxe_chain_url', 'ISOID', 'SCRIPTID', 'SNAPSHOTID',
                    'enable_ipv6', 'enable_private_network', 'private_network', 'label', 'SSHKEYID', 'auto_backups',
                    'APPID', 'userdata', 'notify_activate', 'ddos_protection', 'reserved_ip_v4', 'hostname', 'tag']],
          create_ipv4: [:post, '/v1/server/create_ipv4?api_key=[api_key]', ['SUBID', 'reboot']],
          destroy: [:post, '/v1/server/destroy?api_key=[api_key]', ['SUBID']],
          destroy_ipv4: [:post, '/v1/server/destroy_ipv4?api_key=[api_key]', ['SUBID', 'ip']],
          get_app_info: [:get, '/v1/server/get_app_info?api_key=[api_key]&SUBID=[SUBID]'],
          get_user_data: [:get, '/v1/server/set_user_data?api_key=[api_key]&SUBID=[SUBID]'],
          halt: [:post, '/v1/server/halt?api_key=[api_key]', ['SUBID']],
          iso_attach: [:post, '/v1/server/iso_detach?api_key=[api_key]', ['SUBID', 'ISOID']],
          iso_detach: [:post, '/v1/server/iso_detach?api_key=[api_key]', ['SUBID']],
          iso_status: [:get, '/v1/server/iso_status?api_key=[api_key]&SUBID=[SUBID]'],
          label_set: [:post, '/v1/server/label_set?api_key=[api_key]', ['SUBID', 'label']],
          list: [:get, '/v1/server/list?api_key=[api_key]&SUBID=[SUBID]&tag=[tag]'],
          list_ipv4: [:get, '/v1/server/list_ipv4?api_key=[api_key]&SUBID=[SUBID]'],
          list_ipv6: [:get, '/v1/server/list_ipv6?api_key=[api_key]&SUBID=[SUBID]'],
          neighbors: [:get, '/v1/server/neighbors?api_key=[api_key]&SUBID=[SUBID]'],
          os_change: [:post, '/v1/server/os_change?api_key=[api_key]', ['SUBID', 'OSID']],
          os_change_list: [:get, '/v1/server/os_change_list?api_key=[api_key]&SUBID=[SUBID]'],
          reboot: [:post, '/v1/server/reboot?api_key=[api_key]', ['SUBID']],
          reinstall: [:post, '/v1/server/reinstall?api_key=[api_key]', ['SUBID', 'hostname']],
          restore_backup: [:post, '/v1/server/restore_backup?api_key=[api_key]', ['SUBID', 'BACKUPID']],
          restore_snapshot: [:post, '/v1/server/restore_snapshot?api_key=[api_key]', ['SUBID', 'SNAPSHOTID']],
          reverse_default_ipv4: [:post, '/v1/server/reverse_default_ipv4?api_key=[api_key]', ['SUBID', 'ip']],
          reverse_delete_ipv6: [:post, '/v1/server/reverse_delete_ipv6?api_key=[api_key]', ['SUBID', 'ip']],
          reverse_list_ipv6: [:get, '/v1/server/reverse_list_ipv6?api_key=[api_key]&SUBID=[SUBID]'],
          reverse_set_ipv4: [:post, '/v1/server/reverse_set_ipv4?api_key=[api_key]', ['SUBID', 'ip', 'entry']],
          reverse_set_ipv6: [:post, '/v1/server/reverse_set_ipv6?api_key=[api_key]', ['SUBID', 'ip', 'entry']],
          set_user_data: [:post, '/v1/server/set_user_data?api_key=[api_key]', ['SUBID', 'userdata']],
          start: [:post, '/v1/server/start?api_key=[api_key]', ['SUBID']],
          upgrade_plan: [:post, '/v1/server/upgrade_plan?api_key=[api_key]', ['SUBID', 'VPSPLANID']],
          upgrade_plan_list: [:get, '/v1/server/upgrade_plan_list?api_key=[api_key]&SUBID=[SUBID]']
      },
      Snapshot: {
          destroy: [:post, '/v1/snapshot/destroy?api_key=[api_key]', ['SNAPSHOTID']],
          create: [:post, '/v1/snapshot/create?api_key=[api_key]', ['SUBID']],
          list: [:get, '/v1/snapshot/list?api_key=[api_key]']
      },
      SSHKey: {
          create: [:post, '/v1/sshkey/create?api_key=[api_key]', ['name', 'ssh_key']],
          destroy: [:post, '/v1/sshkey/destroy?api_key=[api_key]', ['SSHKEYID']],
          list: [:get, '/v1/sshkey/list?api_key=[api_key]'],
          update: [:post, '/v1/sshkey/update?api_key=[api_key]', ['SSHKEYID', 'name', 'ssh_key']]
      },
      StartupScript: {
          create: [:post, '/v1/startupscript/create?api_key=[api_key]', ['name', 'script', 'type']],
          destroy: [:post, '/v1/startupscript/destroy?api_key=[api_key]', ['SCRIPTID']],
          list: [:get, '/v1/startupscript/list?api_key=[api_key]'],
          update: [:post, '/v1/startupscript/update?api_key=[api_key]', ['SCRIPTID', 'name', 'script']]
      },
      User: {
          create: [:post, '/v1/user/create?api_key=[api_key]', ['email', 'name', 'password', 'api_enabled', 'acls']],
          delete: [:post, '/v1/user/delete?api_key=[api_key]', ['USERID']],
          list: [:get, '/v1/user/list?api_key=[api_key]'],
          update: [:post, '/v1/user/update?api_key=[api_key]', ['USERID', 'email', 'name', 'password', 'api_enabled', 'acls']]
      }
  }

  DEFINITIONS.each do |resource|
    resource_name = resource[0]

    resource_class = Class.new(Object) do
      DEFINITIONS[resource_name].each do |action, array|
        method_name = array[0]
        path, query = array[1].split('?')
        params = array[2]

        define_singleton_method "_#{action}" do |*args|
          query_for_method = Vultr.process_query_args_from_path(query, args)
          url = [Vultr.api_endpoint, path].join('')

          if query_for_method.nil?
            url
          else
            [url, query_for_method].join('?')
          end
        end

        define_singleton_method action do |*args|
          post_for_method = Vultr.process_params_args_from_keys(params, args)
          Vultr.request_and_respond(method_name, send("_#{action}", *args), post_for_method)
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
    @api_key = api_key
    setup_request!

    @api_key
  end

  def api_key
    return @api_key if @api_key
    'api_key_required'
  end

  def api_endpoint
    'https://api.vultr.com'
  end

  def request_and_respond(method_name, url, body = nil)
    if body.nil?
      resp = Vultr.request.send method_name, url
    else
      resp = Vultr.request.send method_name, url, body
    end
    {status: resp.status, result: resp.body}
  end

  def process_api_key(parts)
    api_key_index = parts.index 'api_key=[api_key]'
    parts[api_key_index].sub!(/\[api_key\]/, api_key) if api_key_index

    parts
  end

  def process_query_args_from_path(query, args)
    return if query.nil?

    parts = query.split('&')
    parts = process_api_key(parts)

    hash = args[-1]
    if hash.is_a?(Hash)
      hash.each do |key, value|
        query_arg_index = parts.index "#{key}=[#{key}]"
        parts[query_arg_index].sub!(/\[.*\]/, value.to_s) if query_arg_index
      end
    end

    parts.delete_if do |x|
      x =~ /=\[.*\]/
    end
    parts.join('&')
  end

  def process_params_args_from_keys(params, args)
    return if params.nil?

    body = Hash.new
    hash = args[-1]
    if hash.is_a?(Hash)
      hash.each do |key, value|
        body[key] = value if params.include? key.to_s
      end
    end

    body unless body.empty?
  end

  private

  def setup_request!
    options = {
        headers: {:Accept => 'application/json'},
        ssl: {verify: false}
    }

    Vultr.request = Faraday.new(options) do |faraday|
      faraday.request :url_encoded
      faraday.response :json, :content_type => 'application/json'
      faraday.response :follow_redirects
      faraday.adapter Faraday.default_adapter
    end
  end
end
