# frozen_string_literal: true

require 'dry-validation'

# :reek:RepeatedConditiona
module HobbyCatcher
  module Forms
    # do validation on test
    class AddAnswer < Dry::Validation::Contract
      params do
        required(:type).filled(:integer)
        required(:difficulty).filled(:integer)
        required(:freetime).filled(:integer)
        required(:emotion).filled(:integer)
      end

      rule(:type) do
        key.failure('you must answer Q1') if value.nil?
      end

      rule(:difficulty) do
        key.failure('you must answer Q2') if value.nil?
      end

      rule(:freetime) do
        key.failure('you must answer Q3') if value.nil?
      end

      rule(:emotion) do
        key.failure('you must answer Q4') if value.nil?
      end
    end
  end
end
