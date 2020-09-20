# frozen_string_literal: true

class TokenManager
  class << self
    def save(token)
      config = Config.load || {}
      config[:token] = token.to_hash

      Config.save(config)
    end

    def load
      config = Config.load
      config.fetch(:token)
    end
  end
end
