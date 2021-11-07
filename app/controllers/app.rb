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
      routing.public

      # GET /
      routing.root do
        view 'home'
      end

      routing.on 'introhobby' do
        routing.is do
          # POST /introhobby/
          routing.post do
            hobby_name = routing.params['hobby_name']
            # Get hobby_introduction from Udemy
            hobby_introduction = Udemy::CourselistMapper
              .new(App.config.UDEMY_TOKEN)
              .find('category', hobby_name)
            

            # Add project to database
            #這是放在COURSELIST裡的
           Repository::For.entity(hobby_introduction).create(hobby_introduction)
            # Redirect viewer to project page
            routing.redirect "introhobby/#{hobby_name}"
          end
        end

        routing.on String do |hobby|
          # GET /introhoppy/hoppy
          routing.get do
           #hobby_introduction = Udemy::CourselistMapper.new(App.config.UDEMY_TOKEN).find('category', hobby)
           #要這樣寫就要像老師的那樣 不然根本要不出來嗚嗚屋
           #可以成功
           hobby_introduction = Repository::For.klass(Entity::Course).all
          #                       .find_hobby(hobby)   

            view 'introhobby', locals: { hobby: hobby_introduction }
          end
        end
      end
    end
  end
end
