# frozen_string_literal: true


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
  end
end
