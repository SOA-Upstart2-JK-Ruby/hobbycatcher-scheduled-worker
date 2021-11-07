# frozen_string_literal: true

module HobbyCatcher
    module Repository
      # Repository for Course
      class Courses

        def self.find_hobby(hobby)
            db_course = Database::CourseOrm.where(category: hobby )
            rebuild_entity(db_course)
        end

        def self.all
            Database::CourseOrm.all.map { |db_course| rebuild_entity(db_course) }
        end

        def self.find_id(id)
          rebuild_entity Database::CourseOrm.first(id: id)
        end
  
        def self.find_title(title)
          rebuild_entity Database::CourseOrm.first(title: title)
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
  
        def self.rebuild_many(db_records)
          db_records.map do |db_course|
            Courses.rebuild_entity(db_course)
          end
        end
  
        def self.db_find_or_create(entity)
          Database::CourseOrm.find_or_create(entity.to_attr_hash)
        end
      end
    end
  end