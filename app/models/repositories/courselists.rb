# frozen_string_literal: true

require_relative 'courses'

module HobbyCatcher
  module Repository
    # Repository for Project Entities
    class Courselists

        def self.create(entity)  
            db_course = PersistCourse.new(entity).create_course
        end

        class PersistCourse
            def initialize(entity)
              @entity = entity
            end
    
            def create_course
              courses = @entity.to_hash[:courses]
              courses.map { |course|
                raise 'Course already exists' if Repository::Courselists.find(course)
                Database::CourseOrm.create(course.reject { |key, _| [:id].include? key })
              }
            end
        end

      def self.find(entity)
        
        find_courseid(entity[:course_id])
      end

      def self.find_courseid(course_id)
        rebuild_entity Database::CourseOrm.first(course_id: course_id)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Course.new(
          id:        db_record.id,
          course_id: db_record.course_id,
          title:     db_record.title,
          url:       db_record.url,
          price:     db_record.price,
          image:     db_record.image,
          rating:    db_record.rating
        )
      end
    end
  end
end
# © 2021 GitHub, Inc.
# Terms
# Privacy
