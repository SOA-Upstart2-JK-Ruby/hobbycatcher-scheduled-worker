# frozen_string_literal: true

require 'dry/monads'

module HobbyCatcher
  module Service
    # Retrieves array of all listed hobby entities
    class GetAnswer
      include Dry::Monads[:result]
      DB_ERR_MSG = 'Having trouble accessing the database'

      def call(answer)
        hobby = Mapper::HobbySuggestions.new(answer).build_entity

        Success(Response::ApiResult.new(status: :created, message: hobby))
      rescue StandardError => e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: DB_ERR_MSG))
      end
    end
  end
end
