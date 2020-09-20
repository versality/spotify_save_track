# frozen_string_literal: true

module Spotify
  class Track < Base
    def currently_playing
      parse_response @token.get('me/player/currently-playing')
    end

    def save(id)
      @token.put('me/tracks', params: { ids: id })
    end

    def remove(id)
      @token.delete('me/tracks', params: { ids: id })
    end
  end
end
