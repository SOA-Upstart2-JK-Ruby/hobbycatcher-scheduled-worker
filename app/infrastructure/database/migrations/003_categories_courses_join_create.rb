# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:categories_courses) do
      primary_key [:category_id, :course_id]
      foreign_key :category_id, :categories
      foreign_key :course_id, :courses

      index [:category_id, :course_id]
    end
  end
end
