# frozen_string_literal: true

class Config
  ROOT_PATH = "#{Dir.home}/.config/#{SpotifySaveTrack::APP_NAME}"
  FILE_PATH = ROOT_PATH + '/config.yml'

  class << self
    def init
      FileUtils.mkdir_p ROOT_PATH
      FileUtils.touch FILE_PATH
    end

    def save(hash)
      File.open(FILE_PATH, 'w') { |file| file.write(hash.to_yaml) }
    end

    def load
      YAML.safe_load(File.read(FILE_PATH), [Symbol])
    end
  end
end
