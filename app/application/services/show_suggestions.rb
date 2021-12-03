# frozen_string_literal: true

require 'dry/monads'
# :reek:NestedIterators
# :reek:TooManyStatements
# :reek:NilCheck
module HobbyCatcher
  module Service
    # Retrieves array of all listed hobby entities
    class ShowSuggestion
      include Dry::Monads[:result]

      def call(input)
        
        categories = Repository::Hobbies.find_owncategories(input)
        # hobby = Repository::Hobbies.find_id(input)

        courses_intros = []
        categories.map do |category|
          courses = Udemy::CourseMapper.new(App.config.UDEMY_TOKEN).find('subcategory', category.name)
          courses.map do |course_intro|
            course = Repository::For.entity(course_intro)
            course.create(course_intro) if course.find(course_intro).nil?
          end
          courses_intros.append(courses)
        end
        # data = []
        # binding.pry
        # data.append(hobby)
        # data.append(categories)
        # data.append(courses_intros)
        Success(Response::ApiResult.new(status: :created, message: courses_intros))
        # data.map do |data| 
        #   Success(Response::ApiResult.new(status: :created, message: data))
        # end
        
        # Success(hobby: hobby, categories: categories, courses_intros: courses_intros)
      rescue StandardError
        Failure(
          Response::ApiResult.new(status: :internal_error, message: DB_ERR)
        )
      end
    end
  end
end
