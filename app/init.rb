# frozen_string_literal: true

%w[model controllers].each do |folder|
  puts "#{folder}/init"
  require_relative "#{folder}/init"
end
