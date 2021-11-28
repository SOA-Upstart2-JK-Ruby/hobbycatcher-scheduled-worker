# frozen_string_literal: true

require 'dry/monads'

module HobbyCatcher
  module Service
    # Retrieves array of all listed hobby entities
    class GetAnswer
      include Dry::Monads[:result]

      def call(answer)
        hobby = Mapper::HobbySuggestions.new(answer).build_entity

        Success(hobby)
      rescue StandardError
        Failure('Having trouble getting answers')
      end
    end
  end
end
