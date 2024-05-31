require "time"

module Vultr
  class Middleware < Faraday::Middleware
    ISO_DATE_FORMAT = /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d+)?(Z|((\+|-)\d{2}:?\d{2}))\Z/xm

    # This method will be called when the response is being processed.
    # You can alter it as you like, accessing things like response_body, response_headers, and more.
    # Refer to Faraday::Env for a list of accessible fields:
    # https://github.com/lostisland/faraday/blob/main/lib/faraday/options/env.rb
    #
    # @param env [Faraday::Env] the environment of the response being processed.
    def on_complete(env)
      parse_dates! env[:body]
    end

    private

    def parse_dates!(value)
      case value
      when Hash
        value.each { |key, element| value[key] = parse_dates!(element) }
      when Array
        value.each_with_index { |element, index| value[index] = parse_dates!(element) }
      when ISO_DATE_FORMAT
        Time.parse(value)
      else
        value
      end
    end
  end
end
