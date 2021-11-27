# frozen_string_literal: true

require_relative 'hobby'

module Views
  # View for a single hobbies list entity
  class HobbiesList
    def initialize(hobbies)
      @hobbies = hobbies.map.with_index { |hobby, i| Hobby.new(hobby, i) }
    end

    def each(&block)
      @hobbies.each(&block)
    end

    def any?
      @hobbies.any?
    end
  end
end
