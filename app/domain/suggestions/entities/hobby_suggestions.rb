# frozen_string_literal: true

module HobbyCatcher
  module Entity
    # Aggregate root for suggestions domain
    class HobbySuggestions < SimpleDelegator
      attr_reader :hobby, :answers, :create_time, :count

      def initialize(hobby:, answers:, create_time:, count:)
        @hobby = hobby
        @answers = answers
        @create_time = create_time
        @count = count
      end

      def hobby_type
        personality = Value::PersonalityTrait.new(type_ans, difficulty_ans, freetime_ans, mood_ans)
        symbol = personality.categorize
        animal_to_hobby(symbol.animal_name)
      end

      def animal_to_hobby(animal)
        case animal
        when 'lion'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 1)
          @hobby = hobby.to_hash
        when 'giraffe'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 2)
          @hobby = hobby.to_hash
        when 'dog'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 3)
          @hobby = hobby.to_hash
        when 'zebra'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 4)
          @hobby = hobby.to_hash
        when 'goat'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 5)
          @hobby = hobby.to_hash
        when 'rabbit'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 6)
          @hobby = hobby.to_hash
        when 'elephant'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 7)
          @hobby = hobby.to_hash
        when 'racoon'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 8)
          @hobby = hobby.to_hash
        when 'cat'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 9)
          @hobby = hobby.to_hash
        when 'owl'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 10)
          @hobby = hobby.to_hash
        when 'koala'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 11)
          @hobby = hobby.to_hash
        when 'hedgehog'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 12)
          @hobby = hobby.to_hash
        when 'turtle'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 13)
          @hobby = hobby.to_hash
        when 'crocodile'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 14)
          @hobby = hobby.to_hash
        when 'panda'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 15)
          @hobby = hobby.to_hash
        when 'hippo'
          hobby = HobbyCatcher::Database::HobbyOrm.where(id: 16)
          @hobby = hobby.to_hash
        end
      end

      # SYMBOLS = [
      #   Value::PersonalityTrait::Lion,
      #   Value::PersonalityTrait::Giraffe,
      #   Value::PersonalityTrait::Dog,
      #   Value::PersonalityTrait::Zebra,
      #   Value::PersonalityTrait::Goat,
      #   Value::PersonalityTrait::Rabbit,
      #   Value::PersonalityTrait::Elephant,
      #   Value::PersonalityTrait::Racoon,
      #   Value::PersonalityTrait::Cat,
      #   Value::PersonalityTrait::Owl,
      #   Value::PersonalityTrait::Koala,
      #   Value::PersonalityTrait::Hedgehog,
      #   Value::PersonalityTrait::Turtle,
      #   Value::PersonalityTrait::Crocodile,
      #   Value::PersonalityTrait::Panda,
      #   Value::PersonalityTrait::Hippo
      # ].freeze
    end
  end
end
