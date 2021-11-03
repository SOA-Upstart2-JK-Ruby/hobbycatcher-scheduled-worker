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

      def load_several(courseid)
        #binding.pry
        CourseMapper.build_entity(@gateway.course(courseid))
        #@gateway.course(courseid).map do |data|
        #  CourseMapper.build_entity(data)
        #end
      end

      def self.build_entity(data)
        DataMapper.new(data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(course_data)
          @course = course_data
        end

        def build_entity
          Entity::Course.new(
            id: nil,
            course_id: course_id,
            title: title,
            url: url,
            price: price,
            image: image,
            rating: rating
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
      end
    end
  end
end
