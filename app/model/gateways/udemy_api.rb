# frozen_string_literal: true

require 'http'
require 'pry'

module HobbyCatcher
  module Udemy
    # Library for Udemy API
    class Api
      def initialize(token)
        @UDEMY_TOKEN = token
      end

      def courselist(field, keyword)
        Request.new(@UDEMY_TOKEN).path("?#{field}=#{keyword}").parse
      end

      def course(courseid)
        Request.new(@UDEMY_TOKEN).path("#{courseid}/?fields[course]=@all").parse
      end

      # Sends out HTTP requests
      class Request
        COURSE_PATH = 'https://www.udemy.com/api-2.0/courses/'

        def initialize(token)
          @ud_token = token
        end

        def path(path)
          get(COURSE_PATH + path)
        end

        def get(url)
          http_response = HTTP.headers(
            'Accept' => 'application/json, text/plain, */*',
            'Authorization' => "Basic #{@ud_token}",
            'Content-Type' => 'application/json;charset=utf-8'
          ).get(url)

          Response.new(http_response).tap do |response|
            raise(response.error) unless response.successful?
          end
        end
      end

      # Decorates HTTP responses
      class Response < SimpleDelegator
        Unauthorized = Class.new(StandardError)
        Forbidden = Class.new(StandardError)
        NotFound = Class.new(StandardError)

        HTTP_ERROR = {
          401 => Unauthorized,
          403 => Forbidden,
          404 => NotFound
        }.freeze

        def successful?
          !HTTP_ERROR.keys.include?(code)
        end

        def error
          HTTP_ERROR[code]
        end
      end
    end
  end
end
