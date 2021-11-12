# frozen_string_literal: true

require 'sequel'

module HobbyCatcher
  module Database
    # Object-Relational Mapper for Courses
    class HobbyOrm < Sequel::Model(:hobbies)
      one_to_many :contain_categories,
                  class:   :'HobbyCatcher::Database::CategoryOrm',
                  key:     :hobby_id

      plugin :timestamps, update_on_create: true
    end
  end
end