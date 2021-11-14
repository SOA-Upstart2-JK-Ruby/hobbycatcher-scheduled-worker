# frozen_string_literal: false

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
            id:           nil,
            ud_course_id: ud_course_id,
            title:        title,
            url:          url,
            image:        image,
            ud_category:  ud_category,
            price:        price,
            rating:       rating,
            owncategory:  owncategory
          )
        end

        def ud_course_id
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
          @course['avg_rating'].zero? ? 0.0 : @course['avg_rating']
        end

        def ud_category
          @course['primary_subcategory']['title']
        end

        def owncategory
          CategoryMapper.build_entity(@course['primary_subcategory']['title'])
        end
      end
    end
  end
end
