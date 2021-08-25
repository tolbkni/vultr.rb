require "ostruct"
require "delegate"
require "json"

module Vultr
  class Object < SimpleDelegator
    def initialize(attributes)
      super to_recursive_ostruct(attributes)
    end

    def to_recursive_ostruct(hash)
      result = hash.each_with_object({}) do |(key, val), memo|
        memo[key] = val.is_a?(Hash) ? to_recursive_ostruct(val) : val
      end
      OpenStruct.new(result)
    end
  end
end
