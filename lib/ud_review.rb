# frozen_string_literal: true

module HobbyCatcher
  # Provides access to review data
  class Review
    def initialize(review_data)
      @review = review_data
    end

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
