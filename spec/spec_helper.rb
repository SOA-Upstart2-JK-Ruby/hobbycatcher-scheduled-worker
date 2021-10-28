# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/fb_api'
require_relative '../lib/ud_api'

# Facebook API
PAGENAME = 'tahrd108'
FIELDS = %w[id name category picture followers_count overall_star_rating website location
            about description ratings posts].join('%2C')
# UDEMY API
COURSEID = '3253422'

# TOKEN
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
FACEBOOK_TOKEN = CONFIG['FACEBOOK_TOKEN']
UDEMY_TOKEN = CONFIG['UDEMY_TOKEN']

CORRECT_FB = YAML.safe_load(File.read('spec/fixtures/facebook_results.yml'))
CORRECT_UD = YAML.safe_load(File.read('spec/fixtures/udemy_results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FB_FILE = 'facebook_api'
CASSETTE_UD_FILE = 'udemy_api'
