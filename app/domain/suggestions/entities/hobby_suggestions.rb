# frozen_string_literal: true

module HobbyCatcher
  module Entity
    # Aggregate root for suggestions domain
    class HobbySuggestions < SimpleDelegator
      attr_reader :answers

      def initialize(answers:)
        @answers = hobby_type(answers)
      end

      def hobby_type(answers)
        personality = Value::PersonalityTrait.new(answers[0],answers[1],answers[2],answers[3])
        if personality.check_input = true
          animal_to_hobby(personality.symbol)
        else
          nil
        end
      end

      def animal_to_hobby(animal)
        hobby = HobbyCatcher::Database::HobbyOrm.find(name: animal.upcase)
        hobby.update(user_num: hobby.user_num+1)
      end
    end
  end
end
