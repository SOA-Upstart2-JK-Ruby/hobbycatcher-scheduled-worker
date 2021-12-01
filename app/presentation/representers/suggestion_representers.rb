# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'course_representer'
require_relative 'category_representer'

module HobbyCatcher
  module Representer
    # Represents folder summary about repo's folder
    class Suggestion < Roar::Decorator
      include Roar::JSON
      property :name
      property :img
      property :user_num
      property :description
      property :time
      property :standard_time

      property :result_url

      property :category, extend: Representer::Category, class: OpenStruct
      property :course, extend: Representer::Course, class: OpenStruct
    end
  end
end