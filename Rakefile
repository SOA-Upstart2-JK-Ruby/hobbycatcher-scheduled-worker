# frozen_string_literal: true

require 'rake/testtask'

task :default do
  puts rake -T
end


USERNAME = 'ruby'
IMAGE = 'script_worker'
VERSION = '0.1.0'

namespace :docker do
  desc 'Build Docker image'
  task :build do
    puts "\nBUILDING WORKER IMAGE"
    sh "docker build --force-rm -t #{USERNAME}/#{IMAGE}:#{VERSION} ."
  end
  
  desc 'Run the local Docker container as a worker'
  task :run do
    env = ENV['WORKER_ENV'] || 'development'
  
    puts "\nRUNNING WORKER WITH LOCAL CONTEXT"
    puts " Running in #{env} mode"
  
    sh 'docker run -e WORKER_ENV -v $(pwd)/config:/worker/config --rm -it ' \
        "#{USERNAME}/#{IMAGE}:#{VERSION}"
  end
  
  desc 'Remove exited containers'
  task :rm do
    sh 'docker rm -v $(docker ps -a -q -f status=exited)'
  end
  
  desc 'List all containers, running and exited'
  task :ps do
    sh 'docker ps -a'
  end
end