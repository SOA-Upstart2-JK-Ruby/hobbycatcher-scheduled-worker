# frozen_string_literal: true

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/fb_api'

PAGENAME = 'tahrd108'
FIELDS = %w[id name category picture followers_count overall_star_rating website location
            about description ratings posts].join('%2C')
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
FACEBOOK_TOKEN = CONFIG['FACEBOOK_TOKEN']
CORRECT = YAML.safe_load(File.read('spec/fixtures/facebook_results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'facebook_api'