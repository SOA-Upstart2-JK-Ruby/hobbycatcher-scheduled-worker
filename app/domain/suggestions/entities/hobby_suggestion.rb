# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module HobbyCatcher
  module Entity
    # Aggregate root for suggestions domain
    class HobbySuggestion < Dry::Struct
      include Dry.Types

      attribute :hobby,         Strict::Integer
      attribute :answers,       Strict::Integer
      attribute :create_time,   Strict::DateTime
      attribute :count,         Strict::Integer
    end
  end
end
