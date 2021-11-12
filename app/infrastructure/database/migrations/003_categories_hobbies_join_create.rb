# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:categories_hobbies) do
      primary_key [:category_id, :hobby_id]
      foreign_key :category_id, :categories
      foreign_key :hobby_id, :hobbies

      index [:category_id, :hobby_id]
    end
  end
end
