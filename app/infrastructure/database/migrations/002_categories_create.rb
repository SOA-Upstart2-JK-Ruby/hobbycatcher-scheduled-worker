# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:categories) do
      primary_key :id
      foreign_key :category_name, 

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
