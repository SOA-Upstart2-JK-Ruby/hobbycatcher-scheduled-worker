# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:categories) do
      primary_key :id
      foreign_key :hobby_id, :hobbies

      Integer  :ud_category_id, unique: true, null: false
      String   :name, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
