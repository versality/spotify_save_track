# frozen_string_literal: true

module Spotify
  class OAuth2
    SITE          = 'https://accounts.spotify.com'
    AUTHORIZE_URL = 'authorize'
    TOKEN_URL     = 'api/token'
    REDIRECT_URI  = 'http://localhost:8888/callback'

    def initialize(client_id:, client_secret:)
      @client_id = client_id
      @client_secret = client_secret
    end

    def authorize_url
      client.auth_code.authorize_url(
        scope: 'user-library-modify user-read-currently-playing',
        redirect_uri: REDIRECT_URI
      )
    end

    def obtain_token(code)
      client.auth_code.get_token(code, redirect_uri: REDIRECT_URI)
    end

    def token
      @token ||= ::OAuth2::AccessToken.from_hash(client, token_manager.load)
      refresh_token! if @token.expired?
      @token
    end

    def token_manager
      TokenManager
    end

    def refresh_token!
      @token = @token.refresh!
      token_manager.save(@token)
    end

    private

    def client
      @client ||= ::OAuth2::Client.new(
        @client_id,
        @client_secret,
        site: SITE,
        authorize_url: AUTHORIZE_URL,
        token_url: TOKEN_URL
      )
    end
  end
end
