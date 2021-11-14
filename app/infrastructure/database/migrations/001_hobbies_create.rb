# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:hobbies) do
      primary_key :id

      String   :name, null: false,unique: true
      String   :img, null: false
      String   :description, null: false
      Integer  :user_num

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
