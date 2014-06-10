require "faraday"
require "faraday_middleware"
require "vultr/version"

module Vultr
  extend self

  DEFINITIONS = {
      Snapshot: {
          list:    [:get, "/v1/snapshot/list?api_key=[api_key]"],
          destroy: [:post, "/v1/snapshot/destroy?api_key=[api_key]", "SNAPSHOTID"],
          create:  [:post, "/v1/snapshot/create?api_key=[api_key]", "SUBID"]
      },
      Plan: {
          list: [:get, "/v1/plans/list"]
      },
      Region: {
          list:         [:get, "/v1/regions/list"],
          availability: [:get, "/v1/regions/availability?DCID=[DCID]"]
      },
      StartupScript: {
          list:    [:get, "/v1/startupscript/list?api_key=[api_key]"],
          destroy: [:post, "/v1/startupscript/destroy?api_key=[api_key]", "SCRIPTID"],
          create:  [:post, "/v1/startupscript/create?api_key=[api_key]", ["name", "script"]]
      },
      Server: {
          list:    [:get, "/v1/server/list?api_key=[api_key]"],
          reboot:  [:post, "/v1/server/reboot?api_key=[api_key]", "SUBID"],
          halt:    [:post, "/v1/server/halt?api_key=[api_key]", "SUBID"],
          start:   [:post, "/v1/server/start?api_key=[api_key]", "SUBID"],
          destroy: [:post, "/v1/server/destroy?api_key=[api_key]", "SUBID"],
          create:  [:post, "/v1/server/create?api_key=[api_key]",
                    ["DCID", "VPSPLANID", "OSID", "ipxe_chain_url", "SCRIPTID", "SNAPSHOTID"]]
      },
      OS: {
          list: [:get, "/v1/os/list"]
      }
  }

  DEFINITIONS.each do |resource|
    resource_name = resource[0]

    resource_class = Class.new(Object) do
      DEFINITIONS[resource_name].each do |action, array|
        method_name = array[0]
        path, query = array[1].split("?")
        params = array[2]

        define_singleton_method "_#{action}" do |*args|
          query_for_method = Vultr.process_query_args_from_path(query, args)
          url = [Vultr.api_endpoint, path].join("")

          if query_for_method.nil?
            url
          else
            [url, query_for_method].join("?")
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
    "api_key_required"
  end

  def api_endpoint
    "https://api.vultr.com"
  end

  def request_and_respond(method_name, url, body = nil)
    if body.nil?
      resp = Vultr.request.send method_name, url
    else
      resp = Vultr.request.send method_name, url, body
    end
    [resp.status, resp.body]
  end

  def process_api_key(parts)
    api_key_index = parts.index "api_key="
    api_key_index = parts.index "&api_key=" if !api_key_index
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
        query_arg_index = parts.index "&#{query_setter}" if !query_arg_index

        unless query_arg_index.nil?
          parts[query_arg_index+1] = value
        end
      end
    end

    parts.join("")
  end

  def process_params_args_from_keys(params, args)
    body = Hash.new
    hash = args[-1]
    if hash.is_a?(Hash)
      hash.each do |key, value|
        body[key] = value unless params.include? key
      end
    end

    body
  end

  private

  def setup_request!
    options = {
        headers: {"Accept" => "application/json"},
        ssl: {verify: false}
    }

    Vultr.request = Faraday.new(options) do |faraday|
      faraday.request :url_encoded
      faraday.response :json, :content_type => "application/json"
      faraday.response :follow_redirects
      faraday.adapter Faraday.default_adapter
    end
  end
end
