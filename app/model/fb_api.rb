# frozen_string_literal: true

require 'http'
require 'pry'
require_relative 'page_info'
require_relative 'review'
require_relative 'post'

module HobbyCatcher
  # Library for Facebook Web API
  class FacebookApi
    module Errors
      # class NotFound < StandardError; end
      # class Unauthorized < StandardError; end
      # class Forbidden < StandardError; end
      class BadRequest < StandardError; end
    end

    HTTP_ERROR = {
      400 => Errors::BadRequest
      # 401 => Errors::Unauthorized,
      # 403 => Errors::Forbidden,
      # 404 => Errors::NotFound
    }.freeze

    def initialize(token)
      @fb_token = token
    end

    def page(page, fields)
      fanpage_url = fb_api_path([page, '?fields=', fields].join)
      fanpage_data = call_fb_url(fanpage_url).parse
      pageinfo(fanpage_data)
    end

    def pageinfo(data)
      PageInfo.new(data, self)
    end

    private

    def fb_api_path(path)
      "https://graph.facebook.com/v12.0/#{path}&access_token=#{@fb_token}"
    end

    def call_fb_url(url)
      result = HTTP.headers('Accept' => 'application/json',
                            'Authorization' => @fb_token).get(url)
      Response.new(result).tap do |response|
        raise(HTTP_ERROR[response.code]) unless response.successful?
      end
    end
  end

  # http response
  class Response < SimpleDelegator
    module Errors
      class BadRequest < StandardError; end
    end

    HTTP_ERROR = {
      400 => Errors::BadRequest
    }.freeze
    def successful?
      !HTTP_ERROR.keys.include?(code)
    end
  end
end
