# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

require_relative 'review.rb'

module HobbyCatcher
  module Entity
    # Domain entity for courses
    class Course < Dry::Struct
      include Dry.Types

      attribute :id,        Strict::Integer
      attribute :title,     Strict::String
      attribute :url,       Strict::String
      attribute :price,     Strict::String
      attribute :image,     Strict::String
      attribute :reviews,   Review
    end
  end
end