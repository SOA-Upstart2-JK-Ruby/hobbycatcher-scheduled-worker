# frozen_string_literal: true

# rubocop:disable Style/Documentation
# rubocop:disable Layout/EmptyLineBetweenDefs
module HobbyCatcher
    module Value
      module QuizAnswer
  
        module UserAnswer
          attr_reader :answer_t, :answer_d, :answer_f, :answer_m
  
          def initialize(answer_t, answer_d, answer_f, answer_m)
            @answer_t = answer_t
            @answer_d = answer_d
            @answer_f = answer_f
            @answer_m = answer_m
          end

        #   def ans
        #     self.class.quiz_ans
        #   end
        end
  
        class Type
          include UserAnswer
          def type_ans
            @type_ans
          end
        end
  
        class Difficulty
          include UserAnswer
          def difficulty_ans
            @difficulty_ans
          end
        end

        class FreeTime
          include UserAnswer
          def freetime_ans
            @freetime_ans
          end
        end

        class Mood
          include UserAnswer
          def mood_ans
            @mood_ans
          end
        end
      end
    end
  end
  # rubocop:enable Layout/EmptyLineBetweenDefs
  # rubocop:enable Style/Documentation