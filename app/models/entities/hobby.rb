# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module HobbyCatcher
  module Entity
    # Domain entity for Hobby
    class Hobby < Dry::Struct
      include Dry.Types

      attribute :id,          Integer.optional
      attribute :name,        Strict::String
      attribute :img,         Strict::String
      attribute :description, Strict::String
      attribute :user_num,    Strict::Integer

      def to_attr_hash
        to_hash.reject { |key, _| %i[id].include? key }
      end
    end
  end
end