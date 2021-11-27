# frozen_string_literal: true

require 'dry/monads'

module HobbyCatcher
  module Service
    # Retrieves array of all listed hobby entities
    class ListHistories
      include Dry::Monads[:result]

      def call(histories_list)
        # Need to change storage method
        # histories = Repository::For.klass(Entity::Hobby)
        #   .find_ids(projects_list)

        Success(histories_list)
      rescue StandardError
        Failure('Could not access cookie')
      end
    end
  end
end