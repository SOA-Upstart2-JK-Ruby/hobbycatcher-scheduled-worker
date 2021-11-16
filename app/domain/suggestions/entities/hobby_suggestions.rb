# frozen_string_literal: true

module HobbyCatcher
  module Entity
    # Aggregate root for suggestions domain
    class HobbySuggestions < SimpleDelegator
      attr_reader :hobby, :answers, :create_time, :count

      def initialize(hobby:, answers:, create_time:, count:)
        @hobby = hobby
        @answers = answers
        @create_time = create_time
        @count = count
      end
    end
  end
end
