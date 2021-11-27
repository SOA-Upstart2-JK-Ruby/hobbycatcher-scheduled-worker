# frozen_string_literal: true

module Views
  # View for a single course entity
  class Course
    def initialize(course)
      @course = course
    end

    def entity
      @course
    end

    def id
      @course.id
    end

    def title
      @course.title
    end

    def url
      @course.url
    end

    def price
      @course.price
    end

    def rating
      @course.rating
    end
  end
end