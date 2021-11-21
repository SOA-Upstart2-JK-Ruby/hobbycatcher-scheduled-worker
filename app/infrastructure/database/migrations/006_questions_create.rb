# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:questions) do
      primary_key :id

      String   :description, null: false, unique: true
      String   :answerA, null: false
      String   :answerB, null: false
      String   :button_name, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
