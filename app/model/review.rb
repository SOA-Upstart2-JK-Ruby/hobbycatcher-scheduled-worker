# frozen_string_literal: true

module InfoHunter
  # Provides access to review data
  class Review
    def initialize(review_data)
      @review = review_data
    end

    def review_date
      @review['created_time']
    end

    def sentiment
      @review['recommendation_type']
    end

    def comment
      @review['review_text']
    end
  end
end
