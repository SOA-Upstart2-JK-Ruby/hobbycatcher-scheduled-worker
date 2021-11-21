# frozen_string_literal: true

require 'http'
require 'yaml'
require 'pry'
require 'delegate'

@config = YAML.safe_load(File.read('config/secrets.yml'))

def ud_api_path(path)
  "https://www.udemy.com/api-2.0/courses/#{path}"
end

def call_ud_url(url)
  HTTP.headers('Accept' => 'application/json, text/plain, */*',
               'Authorization' => "Basic #{@config['development']['UDEMY_TOKEN']}",
               'Content-Type' => 'application/json;charset=utf-8').get(url)
end

ud_response = {}

NEWLINE = "\n"
FIELDS = 'avg_rating,primary_subcategory,image_240x135,price,title,url,id'

# HAPPY course list (clist) request
field = 'subcategory'
keyword = 'Dance'
clist_url = ud_api_path("?#{field}=#{keyword.gsub(' ', '%20')}&fields[course]=#{FIELDS}")
ud_response[clist_url] = call_ud_url(clist_url)
clist = ud_response[clist_url].parse

courses = clist['results']

## HAPPY course request
key = %w[id title url price image rating category]

ud_results = courses.map do |course|
  # course_url = ud_api_path("#{course['id']}/?fields[course]=@all")
  # ud_response[course_url] = call_ud_url(course_url)
  # info = ud_response[course_url].parse

  value = course['id'], course['title'], "https://www.udemy.com#{course['url']}",
          course['price'], course['image_240x135'], course['avg_rating'], course['primary_subcategory']['title']
  key.zip(value).to_h
end

## BAD: wrong course request
bad_course_url = ud_api_path('WrongRequest')
ud_response[bad_course_url] = call_ud_url(bad_course_url)
ud_response[bad_course_url].parse

File.write('spec/fixtures/udemy_results.yml', ud_results.to_yaml)
