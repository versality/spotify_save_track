# frozen_string_literal: true

module SpotifySaveTrack
  APP_NAME = 'spotify_save_track'
end

require 'oauth2'
require 'launchy'
require 'yaml'
require 'socket'
require 'cgi'
require 'fileutils'

require_relative 'spotify_save_track/config'
require_relative 'spotify_save_track/http_server'
require_relative 'spotify_save_track/setup'
require_relative 'spotify_save_track/token_manager'
require_relative 'spotify_save_track/spotify/base'
require_relative 'spotify_save_track/spotify/oauth2'
require_relative 'spotify_save_track/spotify/track'
