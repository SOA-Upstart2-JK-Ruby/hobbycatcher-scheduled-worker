# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'


require_relative 'category_representer'

module HobbyCatcher
  module Representer
    # Represents folder summary about repo's folder
    class Suggestion < Roar::Decorator
      include Roar::JSON
      # property :name
      # property :img
      # property :description
      # property :user_num
      #要抓到entity才可以讀取，所以不能分開
      # property :time
      # property :standard_time

      # property :result_url
      property :ud_course_id
      property :image
      property :url
      property :price
      property :title
      property :rating

      property :owncategory, extend: Representer::Category, class: OpenStruct
      
    end
  end
end