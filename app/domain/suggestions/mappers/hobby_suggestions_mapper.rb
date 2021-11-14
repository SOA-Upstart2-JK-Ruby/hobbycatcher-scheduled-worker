# frozen_string_literal: true

module HobbyCatcher
  module Mapper
    # suggestions services
    class HobbySuggestions
      attr_reader :hobby, :answers, :create_time, :count

      def initialize(results)
        # call data from front-end
        @results = results
      end

      def build_entity
        Entity::HobbySuggestions.new(
          hobby:       @results.hobby,
          answers:     @results.answers,
          create_time: @results.create_time,
          count:       @results.count
        )
      end
    end
  end
end
