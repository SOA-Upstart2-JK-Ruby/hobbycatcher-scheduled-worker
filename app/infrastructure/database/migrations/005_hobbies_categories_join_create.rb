# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:hobbies_categories) do
      primary_key [:hobby_id, :category_id]
      foreign_key :hobby_id, :hobbies
      foreign_key :category_id, :categories

      index [:hobby_id, :category_id]
    end
  end
end
