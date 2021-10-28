# frozen_string_literal: true

require 'http'
require 'pry'
require_relative 'ud_course'
require_relative 'ud_review'

module HobbyCatcher
  # Library for Udemy API
  class UdemyApi
    module Errors
      class NotFound < StandardError; end
      class Unauthorized < StandardError; end
      class Forbidden < StandardError; end
    end

    HTTP_ERROR = {
      401 => Errors::Unauthorized,
      403 => Errors::Forbidden,
      404 => Errors::NotFound
    }.freeze

    def initialize(token)
      @ud_token = token
    end

    def course(courseid)
      course_url = ud_api_path(courseid)
      course_data = call_ud_url(course_url).parse
      Course.new(course_data, self)
    end

    def reviews(courseid)
      reviews_url = ud_api_path(courseid + '/reviews/')
      reviews = call_ud_url(reviews_url).parse
      reviews['results'].map { |review| Review.new(review)}
    end

    private

    def ud_api_path(path)
        "https://www.udemy.com/api-2.0/courses/#{path}"
    end

    def call_ud_url(url)
        result = HTTP.headers('Accept' => 'application/json, text/plain, */*',
                              'Authorization' => "Basic #{@ud_token}",
                              'Content-Type' => 'application/json;charset=utf-8').get(url)
        Response.new(result).tap do |response|
        raise(HTTP_ERROR[response.code]) unless response.successful?
      end
    end
  end

  # http response
  class Response < SimpleDelegator
    module Errors
      class Unauthorized < StandardError; end
      class Forbidden < StandardError; end
      class NotFound < StandardError; end
    end

    HTTP_ERROR = {
      401 => Errors::Unauthorized,
      403 => Errors::Forbidden,
      404 => Errors::NotFound
    }.freeze
    def successful?
      !HTTP_ERROR.keys.include?(code)
    end
  end
end
