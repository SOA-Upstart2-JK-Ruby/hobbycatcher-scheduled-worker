# frozen_string_literal: false

module HobbyCatcher
  # Provides access to review data
  module Udemy
    # Data Mapper: Udemy review -> Review entity
    class ReviewMapper
      def initialize(ud_token, gateway_class = Udemy::Api)
        @token = ud_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end

      def load_several(courseid)
        @gateway.reviews(courseid)['results'].map do |data|
          ReviewMapper.build_entity(data)
        end
      end

      def self.build_entity(data)
        DataMapper.new(data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(review_data)
          @review = review_data
        end

        def build_entity
          Entity::Review.new(
            date: date,
            rating: rating,
            content: content
          )
        end

        private

        def date
          @review['created']
        end

        def rating
          @review['rating']
        end

        def content
          @review['content']
        end
      end
    end
  end
end
