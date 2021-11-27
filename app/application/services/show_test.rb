# frozen_string_literal: true

require 'dry/monads'

module HobbyCatcher
  module Service
    # Retrieves array of all listed hobby entities
    class ShowTest
      include Dry::Monads[:result]

      def call
        questions = Repository::Questions.all

        Success(questions)
      rescue StandardError
        Failure('Having trouble accessing the question database')
      end
    end
  end
end