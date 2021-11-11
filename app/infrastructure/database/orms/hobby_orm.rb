# frozen_string_literal: true

require 'sequel'

module HobbyCatcher
  module Database
    # Object-Relational Mapper for Courses
    class HobbyOrm < Sequel::Model(:hobbies)
      one_to_many :categories,
                  class:      :'HobbyCatcher::Database::CategoryOrm',
                  join_table: :hobbies_categories,
                  left_key:   :hobby_id, 
                  right_key:  :category_id

      plugin :timestamps, update_on_create: true
    end
  end
end