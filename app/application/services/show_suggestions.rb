# frozen_string_literal: true

require 'dry/monads'



module HobbyCatcher
  module Service
    # Retrieves array of all listed hobby entities
    class ShowSuggestion
      include Dry::Monads[:result]

      def call(input)
        hobby = HobbyCatcher::Database::HobbyOrm.where(id: input).first
        categories = hobby.owned_categories
        
        courses_intros = []
        categories.map do |category|
            courses = Udemy::CourseMapper.new(App.config.UDEMY_TOKEN).find('subcategory', category.name)
            courses.map do |course_intro|
              course = Repository::For.entity(course_intro)
              course.create(course_intro) if course.find(course_intro).nil?
            end
            courses_intros.append(courses)
        end
        Success(hobby: hobby,courses_intros: courses_intros )
      rescue StandardError
        Failure('Having trouble accessing Udemy courses')
      end
    end
  end
end
