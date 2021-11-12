# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:courses_categories) do
      primary_key [:course_id, :category_id]
      foreign_key :course_id, :courses
      foreign_key :category_id, :categories

      index [:course_id, :category_id]
    end
  end
end
