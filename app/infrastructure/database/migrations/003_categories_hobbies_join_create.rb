# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:categories_hobbies) do
      primary_key %i[category_id hobby_id]
      foreign_key :category_id, :categories
      foreign_key :hobby_id, :hobbies

      index %i[category_id hobby_id]
    end
  end
end
