# frozen_string_literal: true

require_relative 'course'

module Views
  # View for a single category entity
  class Category
    def initialize(category)
      @category = category
    end

    def entity
      @category
    end

    def id
      @category.id
    end

    def name
      @category.name
    end

    def courses
      @category.owned_courses.map { |course| Course.new(course) }
    end

    def courses_each
      courses.each do |course|
        yield course
      end
    end

    def courses_any?
      courses.any?
    end
  end
end
