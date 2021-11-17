# frozen_string_literal: true

module HobbyCatcher
  module Entity
    # Aggregate root for suggestions domain
    class HobbySuggestions < Dry::Struct
      include Dry.Types

      attribute :hobby,         Strict::Integer
      attribute :answers,       Strict::Integer
      attribute :create_time,   Strict::DateTime
      attribute :count,         Strict::Integer
    end
  end
end
