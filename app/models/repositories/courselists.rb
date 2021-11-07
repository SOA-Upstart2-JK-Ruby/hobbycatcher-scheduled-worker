# frozen_string_literal: true

require_relative 'courses'

module HobbyCatcher
  module Repository
    # Repository for Project Entities
    class Courselists


        def self.create(entity)
            #raise 'Course already exists' if find(entity)
    
            db_course = PersistCourse.new(entity).create_course
            
            #rebuild_entity(db_course)
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
             # Database::CourseOrm.create(@entity.to_attr_hash)
            end
        end

    #   def self.all
    #     Database::CourselistOrm.all.map { |db_courselist| rebuild_entity(db_courselist) }
    #   end

#       def self.find_full_name(owner_name, project_name)
#         # SELECT * FROM `projects` LEFT JOIN `members`
#         # ON (`members`.`id` = `projects`.`owner_id`)
#         # WHERE ((`username` = 'owner_name') AND (`name` = 'project_name'))
#         db_project = Database::ProjectOrm
#           .left_join(:members, id: :owner_id)
#           .where(username: owner_name, name: project_name)
#           .first
#         rebuild_entity(db_project)
#       end

      def self.find(entity)
        
        find_courseid(entity[:course_id])
      end

      def self.find_courseid(course_id)
        rebuild_entity Database::CourseOrm.first(course_id: course_id)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        #創成entity
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

#       def self.find_id(id)
#         db_record = Database::ProjectOrm.first(id: id)
#         rebuild_entity(db_record)
#       end

#       def self.find_origin_id(origin_id)
#         db_record = Database::ProjectOrm.first(origin_id: origin_id)
#         rebuild_entity(db_record)
#       end

#       def self.create(entity)
#         raise 'Project already exists' if find(entity)

#         db_project = PersistProject.new(entity).call
#         rebuild_entity(db_project)
#       end

#       def self.rebuild_entity(db_record)
#         return nil unless db_record

#         Entity::Project.new(
#           db_record.to_hash.merge(
#             owner: Members.rebuild_entity(db_record.owner),
#             contributors: Members.rebuild_many(db_record.contributors)
#           )
#         )
#       end

#       # Helper class to persist project and its members to database
#       class PersistProject
#         def initialize(entity)
#           @entity = entity
#         end

#         def create_project
#           Database::ProjectOrm.create(@entity.to_attr_hash)
#         end

#         def call
#           owner = Members.db_find_or_create(@entity.owner)

#           create_project.tap do |db_project|
#             db_project.update(owner: owner)

#             @entity.contributors.each do |contributor|
#               db_project.add_contributor(Members.db_find_or_create(contributor))
#             end
#           end
#         end
#       end
    end
  end
end
# © 2021 GitHub, Inc.
# Terms
# Privacy
