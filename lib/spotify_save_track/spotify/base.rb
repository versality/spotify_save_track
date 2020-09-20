# frozen_string_literal: true

module Spotify
  class Base
    BASE_URL = 'https://api.spotify.com/v1/'

    def initialize(token:)
      @token = token
      @token.client.site = BASE_URL
    end

    def parse_response(response)
      JSON.parse(response.body, object_class: OpenStruct)
    end
  end
end
