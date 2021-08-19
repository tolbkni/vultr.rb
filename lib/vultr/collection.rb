module Vultr
  class Collection
    attr_reader :data, :total, :next_cursor, :prev_cursor

    def self.from_response(response, key:, type:)
      body = response.body
      new(
        data: body[key].map { |attrs| type.new(attrs) },
        total: body.dig("meta", "total"),
        next_cursor: body.dig("meta", "links", "next"),
        prev_cursor: body.dig("meta", "links", "prev")
      )
    end

    def initialize(data:, total:, next_cursor:, prev_cursor:)
      @data = data
      @total = total
      @next_cursor = next_cursor.empty? ? nil : next_cursor
      @prev_cursor = prev_cursor.empty? ? nil : prev_cursor
    end
  end
end
