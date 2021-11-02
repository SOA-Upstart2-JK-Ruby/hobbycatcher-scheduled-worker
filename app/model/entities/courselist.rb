# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

require_relative 'course'

module HobbyCatcher
  module Entity
    # Domain entity for courses
    class Courselist < Dry::Struct
      include Dry.Types

      attribute :id,       Integer.optional
      attribute :courses,  Strict::Array.of(Course)
    end
  end
end
