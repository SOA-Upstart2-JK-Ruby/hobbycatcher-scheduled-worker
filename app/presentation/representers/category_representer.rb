# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'
require_relative 'hobby_representer'

module HobbyCatcher
  module Representer
    # Represents essential Member information for API output
    # USAGE:
    #   member = Database::MemberOrm.find(1)
    #   Representer::Member.new(member).to_json
    class   Category < Roar::Decorator
      include Roar::JSON

      property :name
      property :ownhobby, extend: Representer::Hobby, class: OpenStruct
    end
  end
end