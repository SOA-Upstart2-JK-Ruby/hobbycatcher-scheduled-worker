# frozen_string_literal: false

require_relative 'review_mapper.rb'

module HobbyCatcher
  module Udemy
    # Data Mapper: Udemy course -> Course entity
    class CourseMapper
      def initialize(ud_token, gateway_class = UdemyApi)
        @token = ud_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end

      def find(courseid)
        data = @gateway.course(courseid)
        build_entity(data)
      end

      def build_entity(data)
        DataMapper.new(data, @token, @gateway_class).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(course, token, gateway_class)
          @course = course
          @review_mapper = ReviewMapper.new(
            token, gateway_class
          )
        end

        def build_entity
          HobbyCatcher::Entity::Project.new(
            id: id,
            title: title,
            url: url,
            price: price,
            image: image,
            reviews: reviews
          )
        end

        def id
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
      
        def reviews
          # @reviews ||= @data_source.reviews(@course['id'].to_s)
          @review_mapper.load_several(@course['id'])
        end
      end
    end
  end
end