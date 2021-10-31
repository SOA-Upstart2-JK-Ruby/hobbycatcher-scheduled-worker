# frozen_string_literal: true

require 'roda'
require 'slim'
require 'yaml'

# COMPANY_YAML = 'spec/fixtures/company.yml'
# COMPANY_LIST = YAML.safe_load(File.read(COMPANY_YAML))

module HobbyCatcher
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :public, root: 'app/views/public'
    plugin :halt

    route do |routing|
      routing.assets # load CSS

      # GET /
      routing.root do
        view 'home'
      end

      routing.on 'introhobby' do
        routing.is do
          # POST /introhobby/
          routing.post do
            hobby_name = routing.params['hobby_name'].downcase
            # routing.halt 400 if COMPANY_LIST[0][cmp_name].nil?
            routing.redirect "introhobby/#{hobby_name}"
          end
        end

        routing.on String do |hobby|
          # GET /introhoppy/hoppy
          routing.get do
            hobby_introduction = Udemy::CourseMapper.new(UD_TOKEN).find(hobby)
            view 'introhobby', locals: { hobby: hobby_introduction }
          end
        end
      end
    end
  end
end
