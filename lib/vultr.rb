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
      Backup: {
          list: [:get, '/v1/backup/list?api_key=[api_key]']
      },
      DNS: {
          create_domain: [:post, '/v1/dns/create_domain?api_key=[api_key]', ['domain', 'serverip']],
          delete_domain: [:post, '/v1/dns/delete_domain?api_key=[api_key]', ['domain']],
          create_record: [:post, '/v1/dns/create_record?api_key=[api_key]', ['domain', 'name', 'type', 'data', 'ttl', 'priority']],
          delete_record: [:post, '/v1/dns/delete_record?api_key=[api_key]', ['domain', 'RECORDID']],
          list: [:get, '/v1/dns/list?api_key=[api_key]'],
          records: [:get, '/v1/dns/records?api_key=[api_key]&domain=[domain]']
      },
      ISO: {
          list: [:get, '/v1/iso/list?api_key=[api_key]']
      },
      OS: {
          list: [:get, '/v1/os/list']
      },
      Plan: {
          list: [:get, '/v1/plans/list']
      },
      Region: {
          list: [:get, '/v1/regions/list'],
          availability: [:get, '/v1/regions/availability?DCID=[DCID]']
      },
      Server: {
          list: [:get, '/v1/server/list?api_key=[api_key]', ['SUBID']],
          reboot: [:post, '/v1/server/reboot?api_key=[api_key]', ['SUBID']],
          halt: [:post, '/v1/server/halt?api_key=[api_key]', ['SUBID']],
          start: [:post, '/v1/server/start?api_key=[api_key]', ['SUBID']],
          destroy: [:post, '/v1/server/destroy?api_key=[api_key]', ['SUBID']],
          create: [:post, '/v1/server/create?api_key=[api_key]',
                   ['DCID', 'VPSPLANID', 'OSID', 'ipxe_chain_url', 'ISOID', 'SCRIPTID', 'SNAPSHOTID',
                    'enable_ipv6', 'enable_private_network', 'label', 'SSHKEYID', 'auto_backups', 'APPID']],
          list_ipv4: [:get, '/v1/server/list_ipv4?api_key=[api_key]&SUBID=[SUBID]'],
          create_ipv4: [:post, '/v1/server/create_ipv4?api_key=[api_key]', ['SUBID', 'reboot']],
          destroy_ipv4: [:post, '/v1/server/destroy_ipv4?api_key=[api_key]', ['SUBID', 'ip']],
          list_ipv6: [:get, '/v1/server/list_ipv6?api_key=[api_key]&SUBID=[SUBID]'],
          label_set: [:post, '/v1/server/label_set?api_key=[api_key]', ['SUBID', 'label']],
          os_change: [:post, '/v1/server/os_change?api_key=[api_key]', ['SUBID', 'OSID']],
          os_change_list: [:get, '/v1/server/os_change_list?api_key=[api_key]&SUBID=[SUBID]'],
          reinstall: [:post, '/v1/server/reinstall?api_key=[api_key]', ['SUBID']],
          restore_backup: [:post, '/v1/server/restore_backup?api_key=[api_key]', ['SUBID', 'BACKUPID']],
          restore_snapshot: [:post, '/v1/server/restore_snapshot?api_key=[api_key]', ['SUBID', 'SNAPSHOTID']],
          reverse_default_ipv4: [:post, '/v1/server/reverse_default_ipv4?api_key=[api_key]', ['SUBID', 'ip']],
          reverse_delete_ipv6: [:post, '/v1/server/reverse_delete_ipv6?api_key=[api_key]', ['SUBID']],
          reverse_list_ipv6: [:get, '/v1/server/reverse_list_ipv6?api_key=[api_key]&SUBID=[SUBID]'],
          reverse_set_ipv4: [:post, '/v1/server/reverse_set_ipv4?api_key=[api_key]', ['SUBID', 'ip']],
          reverse_set_ipv6: [:post, '/v1/server/reverse_set_ipv6?api_key=[api_key]', ['SUBID', 'ip']],
          upgrade_plan: [:post, '/v1/server/upgrade_plan?api_key=[api_key]', ['SUBID', 'VPSPLANID']],
          upgrade_plan_list: [:get, '/v1/server/upgrade_plan_list?api_key=[api_key]&SUBID=[SUBID]']
      },
      Snapshot: {
          list: [:get, '/v1/snapshot/list?api_key=[api_key]'],
          destroy: [:post, '/v1/snapshot/destroy?api_key=[api_key]', ['SNAPSHOTID']],
          create: [:post, '/v1/snapshot/create?api_key=[api_key]', ['SUBID']]
      },
      SSHKey: {
          list: [:get, '/v1/sshkey/list?api_key=[api_key]'],
          create: [:post, '/v1/sshkey/create?api_key=[api_key]', ['name', 'ssh_key']],
          destroy: [:post, '/v1/sshkey/destroy?api_key=[api_key]', ['SSHKEYID']],
          update: [:post, '/v1/sshkey/update?api_key=[api_key]', ['SSHKEYID', 'name', 'ssh_key']]
      },
      StartupScript: {
          list: [:get, '/v1/startupscript/list?api_key=[api_key]'],
          create: [:post, '/v1/startupscript/create?api_key=[api_key]', ['name', 'script', 'type']],
          destroy: [:post, '/v1/startupscript/destroy?api_key=[api_key]', ['SCRIPTID']],
          update: [:post, '/v1/startupscript/update?api_key=[api_key]', ['SCRIPTID', 'name', 'script']]
      },
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
    api_key_index = parts.index 'api_key='
    api_key_index = parts.index '&api_key=' unless api_key_index
    parts[api_key_index + 1] = api_key if api_key_index

    parts
  end

  def process_query_args_from_path(query, args)
    return if query.nil?

    parts = query.split(/\[|\]/)
    parts = process_api_key(parts)

    hash = args[-1]
    if hash.is_a?(Hash)
      hash.each do |key, value|
        query_setter = "#{key}="
        query_arg_index = parts.index query_setter
        query_arg_index = parts.index "&#{query_setter}" unless query_arg_index

        unless query_arg_index.nil?
          parts[query_arg_index+1] = value
        end
      end
    end

    parts.join('')
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
