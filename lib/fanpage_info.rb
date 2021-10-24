# frozen_string_literal: true

require 'http'
require 'yaml'
require 'pry'
require 'delegate'

config = YAML.safe_load(File.read('config/secrets.yml'))
fields = %w[id name category picture followers_count overall_star_rating website location
            about description ratings posts].join('%2C')

def fb_api_path(page, fields, config)
  "https://graph.facebook.com/v12.0/#{page}?fields=#{fields}&access_token=#{config['FACEBOOK_TOKEN']}"
end

def all_fb_url(config, url)
  HTTP.headers('Accept' => 'application/json',
               'Authorization' => config['FACEBOOK_TOKEN'].to_s).get(url)
end

fb_response = {}
fb_results = {}

NEWLINE = "\n"

# # HAPPY fanpage request
fanpage_url = fb_api_path('tahrd108', fields, config)
fb_response[fanpage_url] = call_fb_url(config, fanpage_url)
fanpage = fb_response[fanpage_url].parse

fb_results['id'] = fanpage['id']
fb_results['name'] = fanpage['name']
fb_results['category'] = fanpage['category']
fb_results['profile'] = fanpage['picture']['data']['url']
fb_results['followers'] = fanpage['followers_count']
fb_results['rating'] = fanpage['overall_star_rating']
fb_results['website'] = fanpage['website']
fb_results['location'] = fanpage['location']
fb_results['about'] = fanpage['about'] + NEWLINE + fanpage['description']

fb_results['reviews'] = fanpage['ratings']

fb_results['posts'] = fanpage['posts']

## BAD: wrong fanpage request
bad_fanpage_url = fb_api_path('ABC', fields, config)
fb_response[bad_fanpage_url] = call_fb_url(config, bad_fanpage_url)
fb_response[bad_fanpage_url].parse # makes sure any streaming finishes

File.write('spec/fixtures/facebook_results.yml', fb_results.to_yaml)
