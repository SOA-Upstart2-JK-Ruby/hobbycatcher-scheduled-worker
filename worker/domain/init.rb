# frozen_string_literal: true

folders = %w[hobbies]
folders.each do |folder|
  require_relative "#{folder}/init"
end
