# frozen_string_literal: true

require 'roda'
require 'slim'
require 'yaml'

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
        view_courses = Repository::For.klass(Entity::Course).all
        view 'home', locals: { view_courses: view_courses }
      end

      routing.on 'introhobby' do
        routing.is do
          # POST /introhobby/
          routing.post do
            hobby_name = routing.params['hobby_name']
            # Redirect viewer to project page
            routing.redirect "introhobby/#{hobby_name}"
          end
        end

        routing.on String do |hobby|
          # GET /introhoppy/hoppy
          routing.get do
            #binding.pry
            hobby_intro =HobbyCatcher::Database::HobbyOrm.where(id:hobby).first
            categories_intros =  hobby_intro.first.owned_categories

            categories_intros.map do |category|
             
              hobby_intros =Udemy::CourseMapper.new(App.config.UDEMY_TOKEN).find('subcategory', category.to_hash[:name])
              # Add project to database
              hobby_intros.map do |hobby_intro|
               Repository::For.entity(hobby_intro).create(hobby_intro)
              end
             
            end 
            
            hobby_intros

            view 'introhobby', locals: { hobby: hobby_intros }
          end
        end
      end
    end
  end
end
