# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module HobbyCatcher
  module Entity
    # Domain entity for hobby
    class Question < Dry::Struct
      include Dry.Types

      attribute :id,          Integer.optional
      attribute :description, Strict::String
      attribute :answer_1,    Strict::String
      attribute :answer_2,    Strict::String
      attribute :button_name, Strict::String

      def to_attr_hash
        to_hash.reject { |key, _| %i[id].include? key }
      end
    end
  end
end
