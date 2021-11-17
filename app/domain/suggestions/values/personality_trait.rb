# frozen_string_literal: true

require_relative 'test_answer'
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
      attr_reader :type_ans, :difficulty_ans, :freetime_ans, :mood_ans, :symbol, :description

      def initialize(type_ans, difficulty_ans, freetime_ans, mood_ans)
        super(type_ans, difficulty_ans, freetime_ans, mood_ans)
        @type_ans = Value::Type.new(type_ans)
        @difficulty_ans = Value::Difficulty.new(difficulty_ans)
        @freetime_ans = Value::FreeTime.new(freetime_ans)
        @mood_ans = Value::Mood.new(mood_ans)
      end

      def animal_name
        @symbol
      end
      # :reek:DuplicateMethodCall

      def categorize
        # rubocop:disable Layout/LineLength
        @symbol = 'lion' if @type_ans == 'dynamic' && @difficulty_ans == 'high' && @freetime_ans == 'long' && @mood_ans == 'up'
        @symbol = 'giraffe' if @type_ans == 'static' && @difficulty_ans == 'high' && @freetime_ans == 'long' && @mood_ans == 'up'
        @symbol = 'dog' if @type_ans == 'dynamic' && @difficulty_ans == 'high' && @freetime_ans == 'short' && @mood_ans == 'up'
        @symbol = 'zebra' if @type_ans == 'dynamic' && @difficulty_ans == 'low' && @freetime_ans == 'long' && @mood_ans == 'up'
        @symbol = 'goat' if @type_ans == 'dynamic' && @difficulty_ans == 'high' && @freetime_ans == 'long' && @mood_ans == 'down'
        @symbol = 'rabbit' if @type_ans == 'dynamic' && @difficulty_ans == 'high' && @freetime_ans == 'short' && @mood_ans == 'up'
        @symbol = 'elephant' if @type_ans == 'static' && @difficulty_ans == 'low' && @freetime_ans == 'long' && @mood_ans == 'up'
        @symbol = 'racoon' if @type_ans == 'dynamic' && @difficulty_ans == 'low' && @freetime_ans == 'short' && @mood_ans == 'up'
        @symbol = 'cat' if @type_ans == 'static' && @difficulty_ans == 'high' && @freetime_ans == 'long' && @mood_ans == 'down'
        @symbol = 'owl' if @type_ans == 'dynamic' && @difficulty_ans == 'high' && @freetime_ans == 'short' && @mood_ans == 'down'
        @symbol = 'koala' if @type_ans == 'dynamic' && @difficulty_ans == 'low' && @freetime_ans == 'long' && @mood_ans == 'down'
        @symbol = 'hedgehog' if @type_ans == 'dynamic' && @difficulty_ans == 'low' && @freetime_ans == 'short' && @mood_ans == 'down'
        @symbol = 'turtle' if @type_ans == 'static' && @difficulty_ans == 'low' && @freetime_ans == 'long' && @mood_ans == 'down'
        @symbol = 'crocodile' if @type_ans == 'static' && @difficulty_ans == 'high' && @freetime_ans == 'short' && @mood_ans == 'down'
        @symbol = 'panda' if @type_ans == 'static' && @difficulty_ans == 'low' && @freetime_ans == 'short' && @mood_ans == 'up'
        @symbol = 'hippo' if @type_ans == 'static' && @difficulty_ans == 'low' && @freetime_ans == 'short' && @mood_ans == 'down'
        # rubocop:enable Layout/LineLength
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
