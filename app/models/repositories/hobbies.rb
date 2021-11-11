# frozen_string_literal: true

require_relative 'categories'
require_relative 'courses'

module HobbyCatcher
  module Repository
    # Repository for Hobby Entities
    class Hobbies
      def self.all
        Database::HobbyOrm.all.map { |db_hobby| rebuild_entity(db_hobby) }
      end

      def self.find_full_name(category_name, hobby_name)
        db_hobby = Database::HobbyOrm
          .left_join(:categories, id: :category_id)
          .where(category_name: category_name, hobby_name: hobby_name)
          .first
        rebuild_entity(db_hobby)
      end

      def self.find(entity)
        find_hobby_id(entity.hobby_id)
      end

      def self.find_id(id)
        db_record = Database::HobbyOrm.first(id: id)
        rebuild_entity(db_record)
      end

      def self.find_hobby_id(hobby_id)
        db_record = Database::HobbyOrm.first(hobby_id: hobby_id)
        rebuild_entity(db_record)
      end

      def self.create(entity)
        raise 'Hobby already exists' if find(entity)

        db_hobby = PersistHobby.new(entity).call
        rebuild_entity(db_hobby)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Hobby.new(
          db_record.to_hash.merge(
            categories: Category.rebuild_many(db_record.categories)
          )
        )
      end

      # Helper class to persist hobby and its members to database
      class PersistHobby
        def initialize(entity)
          @entity = entity
        end

        def create_hobby
          Database::HobbyOrm.create(@entity.to_attr_hash)
        end

        def call
          create_hobby.tap do |db_hobby|
            @entity.categories.each do |category|
              db_hobby.add_category(Categories.db_find_or_create(category))
            end
          end
        end
      end
    end
  end
end
