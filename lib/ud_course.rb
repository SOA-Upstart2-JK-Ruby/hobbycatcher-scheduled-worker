# frozen_string_literal: true

require_relative 'ud_review'

module HobbyCatcher
  # Provides access to course data
  class Course
    def initialize(data, data_source)
      @course = data
      @data_source = data_source
    end

    def id
      @course['id']
    end

    def title
      @course['title']
    end

    def url
      'https://www.udemy.com' + @course['url']
    end

    def price
      @course['price']
    end

    def image
      @course['image_240x135']
    end

    def reviews
      @reviews ||= @data_source.reviews(@course['id'].to_s)
    end
  end
end
