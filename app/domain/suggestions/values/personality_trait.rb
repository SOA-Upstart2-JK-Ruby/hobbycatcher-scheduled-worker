# frozen_string_literal: true

<<<<<<< HEAD
=======
# require_relative 'test_answer'
>>>>>>> 7282fd30511a2c959280e2456633f42d1ab88c14
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
# :reek:TooManyInstanceVariables
# :reek:TooManyStatements
module HobbyCatcher
  module Value
    # Value of the user's personality trait (delegates to String)
    class PersonalityTrait < SimpleDelegator
      attr_reader :type_ans, :difficulty_ans, :freetime_ans, :mood_ans, :symbol, :description, :valid

      def initialize(type_ans, difficulty_ans, freetime_ans, mood_ans)
        # super(type_ans, difficulty_ans, freetime_ans, mood_ans)
        @type_ans = type_ans # Value::Type.new(type_ans)
        @difficulty_ans = difficulty_ans # Value::Difficulty.new(difficulty_ans)
        @freetime_ans = freetime_ans # Value::FreeTime.new(freetime_ans)
        @mood_ans = mood_ans # Value::Mood.new(mood_ans)
        @symbol = categorize
      end

      def categorize
        index = (@type_ans + @difficulty_ans + @freetime_ans + @mood_ans).to_i(base=2)
        symbol_arr = ['lion', 'goat', 'dog', 'owl', 'zebra', 'koala', 'racoon', 'hedgehog', 
                      'giraffe', 'cat', 'rabbit', 'crocodile', 'elephant', 'turtle', 'panda', 'hippo']
        symbol_arr[index]
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
