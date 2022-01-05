# frozen_string_literal: true

# require 'sequel'

module HobbyCatcher
  module Database
    # Object-Relational Mapper for Courses
    class CategoryOrm < Sequel::Model(:categories)
      one_to_many :owned_courses,
                  class: :'HobbyCatcher::Database::CourseOrm',
                  key:   :owncategory_id

      many_to_one :ownhobby,
                  class: :'HobbyCatcher::Database::HobbyOrm'

      plugin :timestamps, update_on_create: true

      def self.find_or_create(category_info)
        first(name: category_info[:name]) || create(category_info)
      end
    end
  end
end
