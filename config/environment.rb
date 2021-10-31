# frozen_string_literal: true

require 'roda'
require 'yaml'
module HobbyCatcher
  # Configuration for the App
  class App < Roda
    CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
    UD_TOKEN = CONFIG['UDEMY_TOKEN']
  end
end
