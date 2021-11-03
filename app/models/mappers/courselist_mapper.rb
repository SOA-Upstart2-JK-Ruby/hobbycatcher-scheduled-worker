# frozen_string_literal: false

require_relative 'course_mapper'

module HobbyCatcher
  module Udemy
    # Data Mapper: Udemy course -> Course entity
    class CourselistMapper
      def initialize(ud_token, gateway_class = Udemy::Api)
        @token = ud_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end

      def find(field, keyword)
        data = @gateway.courselist(field, keyword)
        build_entity(data)
      end

      def build_entity(data)
        DataMapper.new(data, @token, @gateway_class).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(courselist, token, gateway_class)
          @courselist = courselist['results']
          @course_mapper = CourseMapper.new(token, gateway_class)
        end

        def build_entity
          HobbyCatcher::Entity::Courselist.new(
            id: nil,
            courses: courses,
          )
        end

        def courses
          #binding.pry
          # @courselist.map{ |c| c['id'].to_s}
          @courselist.map do |course|
            @course_mapper.load_several(course['id'].to_s)
          end
        end
      end
    end
  end
end
