# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:courselists) do
      primary_key :id
      foreign_key :course_id, :courses

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
