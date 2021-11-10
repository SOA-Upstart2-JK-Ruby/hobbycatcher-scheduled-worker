# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:categories) do
      primary_key :id
      foreign_key :category_owner_id,

      Integer  :course_id, unique: true, null: false
      String   :category_name, null: false
      String   :type, null: false


      DateTime :created_at
      DateTime :updated_at
    end
  end
end
