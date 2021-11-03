# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:courses) do
      primary_key :id

      Integer  :course_id, unique: true
      String   :title, unique: true, null: false
      String   :url, unique: true, null: false
      String   :price
      String   :image
      Float    :rating

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
