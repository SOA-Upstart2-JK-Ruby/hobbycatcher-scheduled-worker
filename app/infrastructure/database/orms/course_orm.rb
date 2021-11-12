# frozen_string_literal: true

require 'sequel'

module HobbyCatcher
  module Database
    # Object-Relational Mapper for Courses
    class CourseOrm < Sequel::Model(:courses)
      many_to_one :category,
                  class: :'HobbyCatcher::Database::CategoryOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
