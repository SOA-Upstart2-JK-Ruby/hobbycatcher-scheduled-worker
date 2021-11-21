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
      attr_reader :type_ans, :difficulty_ans, :freetime_ans, :mood_ans, :symbol, :description, :valid

      def initialize(type_ans, difficulty_ans, freetime_ans, mood_ans)
        # super(type_ans, difficulty_ans, freetime_ans, mood_ans)
        @type_ans = type_ans # Value::Type.new(type_ans)
        @difficulty_ans = difficulty_ans # Value::Difficulty.new(difficulty_ans)
        @freetime_ans = freetime_ans # Value::FreeTime.new(freetime_ans)
        @mood_ans = mood_ans # Value::Mood.new(mood_ans)
        @symbol = categorize
        #@valid = check_input
      end

      # def animal_name
      #   @symbol
      # end
      # :reek:DuplicateMethodCall

      def categorize
        symbol = 'lion'      if @type_ans == 1 && @difficulty_ans == 1 && @freetime_ans == 1 && @mood_ans == 1
        symbol = 'giraffe'   if @type_ans == 2 && @difficulty_ans == 1 && @freetime_ans == 1 && @mood_ans == 1
        symbol = 'dog'       if @type_ans == 1 && @difficulty_ans == 1 && @freetime_ans == 2 && @mood_ans == 1
        symbol = 'zebra'     if @type_ans == 1 && @difficulty_ans == 2 && @freetime_ans == 1 && @mood_ans == 1
        symbol = 'goat'      if @type_ans == 1 && @difficulty_ans == 1 && @freetime_ans == 1 && @mood_ans == 2
        symbol = 'rabbit'    if @type_ans == 2 && @difficulty_ans == 1 && @freetime_ans == 2 && @mood_ans == 1
        symbol = 'elephant'  if @type_ans == 2 && @difficulty_ans == 2 && @freetime_ans == 1 && @mood_ans == 1
        symbol = 'racoon'    if @type_ans == 1 && @difficulty_ans == 2 && @freetime_ans == 2 && @mood_ans == 1
        symbol = 'cat'       if @type_ans == 2 && @difficulty_ans == 1 && @freetime_ans == 1 && @mood_ans == 2
        symbol = 'owl'       if @type_ans == 1 && @difficulty_ans == 1 && @freetime_ans == 2 && @mood_ans == 2
        symbol = 'koala'     if @type_ans == 1 && @difficulty_ans == 2 && @freetime_ans == 1 && @mood_ans == 2
        symbol = 'hedgehog'  if @type_ans == 1 && @difficulty_ans == 2 && @freetime_ans == 2 && @mood_ans == 2
        symbol = 'turtle'    if @type_ans == 2 && @difficulty_ans == 2 && @freetime_ans == 1 && @mood_ans == 2
        symbol = 'crocodile' if @type_ans == 2 && @difficulty_ans == 1 && @freetime_ans == 2 && @mood_ans == 2
        symbol = 'panda'     if @type_ans == 2 && @difficulty_ans == 2 && @freetime_ans == 2 && @mood_ans == 1
        symbol = 'hippo'     if @type_ans == 2 && @difficulty_ans == 2 && @freetime_ans == 2 && @mood_ans == 2
        symbol
      end

      # def check_input
      #   if @type_ans.nil? || @difficulty_ans.nil? || @freetime_ans.nil? || @mood_ans.nil?
      #     @valid = false
      #   else
      #     @valid = true
      #   end
      # end
    end
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
