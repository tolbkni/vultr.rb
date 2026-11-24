module Vultr
  class Error < StandardError
  end

  # One per status the API answers with, so callers can rescue a status rather than
  # match the message. Each is a Vultr::Error, so rescuing that still catches them all.
  class BadRequest < Error; end

  class Unauthorized < Error; end

  class Forbidden < Error; end

  class NotFound < Error; end

  class RateLimited < Error; end

  class ServerError < Error; end
end
