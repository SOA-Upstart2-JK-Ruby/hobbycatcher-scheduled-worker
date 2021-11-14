# frozen_string_literal: true

# rubocop:disable Style/Documentation
module HobbyCatcher
  module Value
    module QuizAnswer
      module UserAnswer
        attr_reader :answer_t, :answer_d, :answer_f, :answer_m

        def setup_useranswer_module(answer_t, answer_d, answer_f, answer_m)
          @answer_t = answer_t
          @answer_d = answer_d
          @answer_f = answer_f
          @answer_m = answer_m
        end

        class Type
          include UserAnswer
          def type_ans
            @type_ans = 'dynamic' if answer_t == 1
            @type_ans = 'static' if answer_t == 2
          end
        end

        class Difficulty
          include UserAnswer
          def difficulty_ans
            @difficulty_ans = 'high' if answer_d == 1
            @difficulty_ans = 'low' if answer_d == 2
          end
        end

        class FreeTime
          include UserAnswer
          def freetime_ans
            @freetime_ans = 'long' if answer_f == 1
            @freetime_ans = 'short' if answer_f == 2
          end
        end

        class Mood
          include UserAnswer
          def mood_ans
            @mood_ans = 'up' if answer_m == 1
            @mood_ans = 'down' if answer_m == 2
          end
        end
      end
    end
  end
end
# rubocop:enable Style/Documentation
