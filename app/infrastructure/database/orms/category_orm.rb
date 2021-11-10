# frozen_string_literal: true

require 'sequel'

module HobbyCatcher
  module Database
    # Object-Relational Mapper for Courses
    class CategoryOrm < Sequel::Model(:courses)
      one_to_many :owned_courses,
                   class: :'HobbyCatcher::Database::CourseOrm',
                   key:   :course_owner_id

      many_to_one :belong_type,
                   class: :'HobbyCatcher::Database::HobbyOrm',

      plugin :timestamps, update_on_create: true

    end
  end
end