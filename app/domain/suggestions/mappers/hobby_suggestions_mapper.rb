# frozen_string_literal: true

module HobbyCatcher
  module Mapper
    # suggestions services
    class HobbySuggestions
      attr_reader :answers

      def initialize(answers)
        # call data from front-end
        @answers = answers
      end

      def build_entity
        Entity::HobbySuggestions.new(
          answers:     @answers,
          # create_time: @results.create_time,
          # count:       @results.count
        )
      end
    end
  end
end
