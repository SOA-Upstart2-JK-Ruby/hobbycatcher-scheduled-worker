# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:courselists_courses) do
      primary_key %i[courselist_id course_id]
      foreign_key :courselist_id, :courselists
      foreign_key :course_id, :courses

      index %i[courselist_id course_id]
    end
  end
end
