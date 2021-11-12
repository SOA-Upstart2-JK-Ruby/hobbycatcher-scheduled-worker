# frozen_string_literal: true

require_relative 'courses'

module HobbyCatcher
  module Repository
    # Repository for Categories
    class Categories
      def self.all
        Database::CategoryOrm.all.map { |db_category| rebuild_entity(db_category) }
      end

      def self.find_full_name(hobby_name, category_name)
        db_category = Database::CategoryOrm
          .left_join(:hobbies, id: :hobby_id)
          .where(hobbyname: hobby_name, name: category_name)
          .first
        rebuild_entity(db_category)
      end

      def self.find(entity)
        find_ud_category_id(entity.ud_category_id)
      end

      def self.find_id(id)
        rebuild_entity Database::CategoryOrm.first(id: id)
      end

      def self.find_name(name)
        rebuild_entity Database::CategoryOrm.first(name: name)
      end

      def self.find_ud_category_id(ud_category_id)
        rebuild_entity Database::CategoryOrm.first(ud_category_id: ud_category_id)
      end

      def self.create(entity)
        raise 'Category already exists' if find(entity)

        db_category = PersistCategory.new(entity).call
        rebuild_entity(db_category)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Category.new(
          # id:            db_record.id,
          # category_id:   db_record.category_id,
          # category_name: db_record.category_name,
          # type:          db_record.type,
          db_record.to_hash.merge(
            category: Hobbies.rebuild_entity(db_record.belong_hobby)
          )
        )
      end

      # def self.rebuild_many(db_records)
      #   db_records.map do |db_course|
      #     Courses.rebuild_entity(db_course)
      #   end
      # end
      class PersistCategory
        def initialize(entity)
          @entity = entity
        end

        def create_category
          Database::CategoryOrm.create(@entity.to_attr_hash)
        end

        def call
          belong_hobby = Hobbies.db_find_or_create(@entity.belong_hobby)

          create_category.tap do |db_category|
            db_category.update(belong_hobby: belong_hobby)
          end
        end 
      end

      def self.db_find_or_create(entity)
        Database::CategoryOrm.find_or_create(entity.to_attr_hash)
      end
    end
  end
end
