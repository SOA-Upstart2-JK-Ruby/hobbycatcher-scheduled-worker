# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../init'

# UDEMY API
COURSEID = '3253422'
FIELD = 'category'
KEYWORD = 'Design'

# TOKEN
UDEMY_TOKEN = HobbyCatcher::App.config.UDEMY_TOKEN

CORRECT_UD = YAML.safe_load(File.read('spec/fixtures/udemy_results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_UD_FILE = 'udemy_api'
