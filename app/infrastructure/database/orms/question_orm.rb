# frozen_string_literal: true

# require 'sequel'

module HobbyCatcher
    module Database
      # Object-Relational Mapper for Courses
      class QuestionOrm < Sequel::Model(:questions)

        plugin :timestamps, update_on_create: true
  
        def self.find_or_create(question_info)
          first(button_name: question_info[:button_name]) || create(question_info)
        end
      end
    end
  end
  