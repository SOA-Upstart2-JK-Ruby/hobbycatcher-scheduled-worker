# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module HobbyCatcher
  module Representer
    # Represents folder summary about repo's folder
    class Hobby < Roar::Decorator
      include Roar::JSON
      property :id
      property :name
      property :img
      property :description
      property :user_num
    end
  end
end
