# frozen_string_literal: true

folders = %w[hobbies suggestions]
folders.each do |folder|
  require_relative "#{folder}/init"
end