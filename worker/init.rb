# frozen_string_literal: true

%w[domain infrastructure application presentation].each do |folder|
  require_relative "#{folder}/init"
end
