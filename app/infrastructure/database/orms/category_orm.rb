# frozen_string_literal: true

require 'sequel'

module HobbyCatcher
  module Database
    # Object-Relational Mapper for Courses
    class CategoryOrm < Sequel::Model(:categories)
      one_to_many :courses,
                  class:      :'HobbyCatcher::Database::CourseOrm',
                  join_table: :categories_courses,
                  left_key:   :category_id,
                  right_key:  :course_id

      many_to_one :belong_hobby,
                  class: :'HobbyCatcher::Database::HobbyOrm'
                  # join_table: :hobbies_categories,
                  # left_key:   :hobby_id,
                  # right_key:  :category_id

      plugin :timestamps, update_on_create: true

    end
  end
end