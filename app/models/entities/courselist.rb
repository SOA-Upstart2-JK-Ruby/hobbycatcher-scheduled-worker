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

      # def to_attr_hash
      #   to_hash.reject { |key, _| [:id].include? key }
      # end
      # def to_attr_hash
      #   to_hash.reject { |key, _| %i[id courses].include? key }
      # end
    end
  end
end
