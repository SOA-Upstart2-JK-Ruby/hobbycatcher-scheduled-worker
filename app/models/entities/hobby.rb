# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module HobbyCatcher
  module Entity
    # Domain entity for courses
    class Hobby < Dry::Struct
      include Dry.Types

      attribute :id,          Integer.optional
      attribute :hobby_id,    Strict::Integer
      attribute :hobby_name,  Strict::String
      attribute :description, Strict::String
      attribute :hobby_img,   Strict::String
      attribute :count,       Strict::Integer

    end
  end
end