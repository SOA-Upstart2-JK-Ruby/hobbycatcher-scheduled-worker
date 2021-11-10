# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module HobbyCatcher
  module Entity
    # Domain entity for courses
    class Category < Dry::Struct
      include Dry.Types

      attribute :id,              Integer.optional
      attribute :category_id,     Strict::Integer
      attribute :category_name,   Strict::String
      attribute :type,            Strict::String

    end
  end
end