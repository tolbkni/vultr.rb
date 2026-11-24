module Vultr
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    private

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, headers)
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body, headers)
    end

    def patch_request(url, body:, headers: {})
      handle_response client.connection.patch(url, body, headers)
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection.put(url, body, headers)
    end

    def delete_request(url, params: {}, headers: {})
      handle_response client.connection.delete(url, params, headers)
    end

    def handle_response(response)
      case response.status
      when 400
        raise BadRequest, "Your request was malformed. #{response.body["error"]}"
      when 401
        raise Unauthorized, "You did not supply valid authentication credentials. #{response.body["error"]}"
      when 403
        raise Forbidden, "You are not allowed to perform that action. #{response.body["error"]}"
      when 404
        raise NotFound, "No results were found for your request. #{response.body["error"]}"
      when 429
        raise RateLimited, "Your request exceeded the API rate limit. #{response.body["error"]}"
      when 500
        raise ServerError, "We were unable to perform the request due to server-side problems. #{response.body["error"]}"
      when 503
        raise RateLimited, "You have been rate limited for sending more than 20 requests per second. #{response.body["error"]}"
      end

      response
    end
  end
end
