# frozen_string_literal: true

require_relative 'courses'

module HobbyCatcher
  module Repository
    # Repository for Categories
    class Categories
      def self.find_id(id)
        rebuild_entity Database::CategoryOrm.first(id: id)
      end

      def self.find_category_name(category_name)
        rebuild_entity Database::CategoryOrm.first(category_name: category_name)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Category.new(
          id:            db_record.id,
          category_id:   db_record.category_id,
          category_name: db_record.category_name,
          type:          db_record.type,
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
