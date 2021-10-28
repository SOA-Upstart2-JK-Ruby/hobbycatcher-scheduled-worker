# frozen_string_literal: true

require 'http'
require 'yaml'
require 'pry'
require 'delegate'

config = YAML.safe_load(File.read('config/secrets.yml'))

def ud_api_path(path)
  "https://www.udemy.com/api-2.0/courses/#{path}"
end

def call_ud_url(config, url)
  HTTP.headers('Accept' => 'application/json, text/plain, */*',
               'Authorization' => "Basic #{config['UDEMY_TOKEN']}",
               'Content-Type' => 'application/json;charset=utf-8').get(url)
end

ud_response = {}
ud_results = {}

NEWLINE = "\n"

## HAPPY course list (clist) request
# clist_url = ud_api_path('?category=Lifestyle')
# ud_response[clist_url] = call_ud_url(config, clist_url)
# clist = ud_response[clist_url].parse
# courses = clist['results']

# key = ['id', 'title', 'url', 'price', 'image']
# ud_results = courses.map do |course|
#   value = course['id'],course['title'],course['url'],course['price'],course['image_240x135']
#   Hash[key.zip(value)]
# end

## HAPPY course request
course_url = ud_api_path('3253422')
ud_response[course_url] = call_ud_url(config, course_url)
course = ud_response[course_url].parse

ud_results['id'] = course['id']
ud_results['title'] = course['title']
ud_results['url'] = 'https://www.udemy.com' + course['url']
ud_results['price'] = course['price']
ud_results['image'] = course['image_240x135']

## HAPPY course review (review) request
reviews_url = course_url + '/reviews/'
ud_response[reviews_url] = call_ud_url(config, reviews_url)
reviews = ud_response[reviews_url].parse

ud_results['reviews'] = reviews['results'].map do |review|
  key = ['date', 'rating', 'content']
  value = review['created'],review['rating'],review['content']
  Hash[key.zip(value)]
end

## BAD: wrong course request
bad_course_url = ud_api_path('WrongRequest')
ud_response[bad_course_url] = call_ud_url(config, bad_course_url)
ud_response[bad_course_url].parse 

File.write('spec/fixtures/udemy_results.yml', ud_results.to_yaml)
