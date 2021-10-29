# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module HobbyCatcher
  module Entity
    # Domain entity for course reviews
    class Review < Dry::Struct
      include Dry.Types

      attribute :date,      Strict::DateTime
      attribute :rating,    Float
      attribute :content,   Strict::String.optional
    end
  end
end