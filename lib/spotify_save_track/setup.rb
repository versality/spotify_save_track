# frozen_string_literal: true

class Setup
  def initialize(
    spotify_oauth: Spotify::OAuth2,
    http_server:   HTTPServer.new,
    token_manager: TokenManager,
    config:        Config
  )
    @spotify_oauth = spotify_oauth
    @http_server   = http_server
    @token_manager = token_manager
    @config        = config
  end

  def call(client_id:, client_secret:)
    @client_id = client_id
    @client_secret = client_secret

    init_config!

    authorize(spotify.authorize_url)

    response = @http_server.call
    code     = parse_response(response)
    token    = spotify.obtain_token(code)

    @token_manager.save(token)
  end

  private

  def init_config!
    @config.init
    @config.save(
      credentials: {
        client_id: @client_id,
        client_secret: @client_secret
      }
    )
  end

  def spotify
    @spotify ||= @spotify_oauth.new(
      client_id: @client_id,
      client_secret: @client_secret
    )
  end

  def authorize(url)
    Launchy.open(url)
  end

  def parse_response(response)
    response.fetch('/callback?code').first
  end
end
