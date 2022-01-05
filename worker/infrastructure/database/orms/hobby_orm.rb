# frozen_string_literal: true

# require 'sequel'

module HobbyCatcher
  module Database
    # Object-Relational Mapper for Courses
    class HobbyOrm < Sequel::Model(:hobbies)
      one_to_many :owned_categories,
                  class: :'HobbyCatcher::Database::CategoryOrm',
                  key:   :ownhobby_id

      plugin :timestamps, update_on_create: true

      def self.find_or_create(hobby_info)
        first(name: hobby_info[:name]) || create(hobby_info)
      end
    end
  end
end
