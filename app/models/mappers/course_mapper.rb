# frozen_string_literal: false

# require_relative 'course_mapper'

module HobbyCatcher
  module Udemy
    # Data Mapper: Udemy course -> Course entity
    class CourseMapper
      def initialize(ud_token, gateway_class = Udemy::Api)
        @token = ud_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end

      def find(field, keyword)
        data = @gateway.course(field, keyword)
        build_entity(data)

      end

      def build_entity(data)
        data['results'].map do |datam|
          DataMapper.new(datam).build_entity
        end
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(course)
          @course = course
        end

        def build_entity
          HobbyCatcher::Entity::Course.new(
            id:        nil,
            course_id: course_id,
            title:     title,
            url:       url,
            price:     price,
            image:     image,
            rating:    rating,
            category:  category
          )
        end

        def course_id
          @course['id']
        end

        def title
          @course['title']
        end

        def url
          "https://www.udemy.com#{@course['url']}"
        end

        def price
          @course['price']
        end

        def image
          @course['image_240x135']
        end

        def rating
          @course['avg_rating']
        end

        def category
          @course['primary_category']['title']
        end
      end
    end
  end
end
