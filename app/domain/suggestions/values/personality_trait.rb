# frozen_string_literal: true

require_relative 'quiz_answer'

module HobbyCatcher
  module Value
    # Value of the user's personality trait (delegates to String)
    class PersonalityTrait < SimpleDelegator
      # rubocop:disable Style/RedundantSelf
      attr_reader :type_ans, :difficulty_ans, :freetime_ans, :mood_ans

      def initialize(type_ans, difficulty_ans, freetime_ans, mood_ans)
        @type_ans = type_ans
        @difficulty_ans = difficulty_ans
        @freetime_ans = freetime_ans
        @mood_ans = mood_ans
      end

      def symbol
        @symbol
      end

      def description
        @description
      end

      def analysis
        @symbol = 'lion' if type_ans == 'dynamic' && difficulty_ans == 'high' && freetime_ans == 'long' && mood_ans == 'up'
        @symbol = 'giraffe' if type_ans == 'static' && difficulty_ans == 'high' && freetime_ans == 'long' && mood_ans == 'up'
        @symbol = 'dog' if type_ans == 'dynamic' && difficulty_ans == 'high' && freetime_ans == 'short' && mood_ans == 'up'
        @symbol = 'zebra' if type_ans == 'dynamic' && difficulty_ans == 'low' && freetime_ans == 'long' && mood_ans == 'up'
        @symbol = 'goat' if type_ans == 'dynamic' && difficulty_ans == 'high' && freetime_ans == 'long' && mood_ans == 'down'
        @symbol = 'rabbit' if type_ans == 'dynamic' && difficulty_ans == 'high' && freetime_ans == 'short' && mood_ans == 'up'
        @symbol = 'elephant' if type_ans == 'static' && difficulty_ans == 'low' && freetime_ans == 'long' && mood_ans == 'up'
        @symbol = 'racoon' if type_ans == 'dynamic' && difficulty_ans == 'low' && freetime_ans == 'short' && mood_ans == 'up'
        @symbol = 'cat' if type_ans == 'static' && difficulty_ans == 'high' && freetime_ans == 'long' && mood_ans == 'down'
        @symbol = 'owl' if type_ans == 'dynamic' && difficulty_ans == 'high' && freetime_ans == 'short' && mood_ans == 'down'
        @symbol = 'koala' if type_ans == 'dynamic' && difficulty_ans == 'low' && freetime_ans == 'long' && mood_ans == 'down'
        @symbol = 'hedgehog' if type_ans == 'dynamic' && difficulty_ans == 'low' && freetime_ans == 'short' && mood_ans == 'down'
        @symbol = 'turtle' if type_ans == 'static' && difficulty_ans == 'low' && freetime_ans == 'long' && mood_ans == 'down'
        @symbol = 'crocodile' if type_ans == 'static' && difficulty_ans == 'high' && freetime_ans == 'short' && mood_ans == 'down'
        @symbol = 'panda' if type_ans == 'static' && difficulty_ans == 'low' && freetime_ans == 'short' && mood_ans == 'up'
        @symbol = 'hippo' if type_ans == 'static' && difficulty_ans == 'low' && freetime_ans == 'short' && mood_ans == 'down'
      end
      # rubocop:enable Style/RedundantSelf
    end
  end
end