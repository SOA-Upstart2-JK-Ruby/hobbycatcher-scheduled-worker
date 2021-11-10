# frozen_string_literal: true

require_relative 'courses'

module HobbyCatcher
  module Repository
    # Finds the right repository for an entity object or class
    module For
      ENTITY_REPOSITORY = {
        Entity::Course => Courses
      }.freeze

      def self.klass(entity_klass)
        ENTITY_REPOSITORY[entity_klass]
      end

      def self.entity(entity_objects)
        ENTITY_REPOSITORY[entity_objects[0].class]
      end
    end
  end
end
