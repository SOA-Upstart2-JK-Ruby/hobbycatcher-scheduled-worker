# frozen_string_literal: true

# rubocop:disable Style/Documentation
# rubocop:disable Layout/EmptyLineBetweenDefs
module HobbyCatcher
    module Value
      module QuizParameter
  
        module Answer
          attr_reader :answer_t, :answer_d, :answer_f, :answer_m
  
          def initialize(answer_t, answer_d, answer_f, answer_m)
            @answer_t = answer_t
            @answer_d = answer_d
            @answer_f = answer_f
            @answer_m = answer_m
          end

          def ans
            self.class.quiz_ans
          end
  
        end
  
        class Type
          include Answer
          def self.quiz_ans() = 'Type'
        end
  
        class Difficulty
          include Answer
          def self.quiz_ans() = 'Difficulty'
        end

        class FreeTime
          include Answer
          def self.quiz_ans() = 'FreeTime'
        end

        class Mood
          include Answer
          def self.quiz_ans() = 'Mood'
        end
  
      end
    end
  end
  # rubocop:enable Layout/EmptyLineBetweenDefs
  # rubocop:enable Style/Documentation