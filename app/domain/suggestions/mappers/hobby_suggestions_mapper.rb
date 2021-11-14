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

      def for_suggest
        @hobby = @results.hobby
        @answers = @results.answers
        @create_time = @results.create_time
        @count = @results.count

      def build_entity
        Entity::HobbySuggestions.new(
          hobby:       @hobby,
          answers:     @answers,
          create_time: @create_time,
          count:       @count
        )
      end
    end
  end
end
