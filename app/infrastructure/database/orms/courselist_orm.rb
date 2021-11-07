# frozen_string_literal: true

require 'sequel'

module HobbyCatcher
  module Database
    # Object Relational Mapper for Courselist
    class CourselistOrm < Sequel::Model(:courselists)
      one_to_many :courses,
                  class: :'HobbyCatcher::Database::CourseOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end