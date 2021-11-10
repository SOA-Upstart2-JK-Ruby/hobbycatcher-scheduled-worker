# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:courselists_courses) do
      primary_key :id

      Integer  :hobby_id, unique: true, null: false
      String   :hobby_name, null: false,unique: true
      String   :description, null: false
      String   :hobby_img, null: false
      Integer  :count, 


      DateTime :created_at
      DateTime :updated_at
    end
  end
end
