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
            categories_intros = hobby_intro.owned_categories
            courses_intros = []
            categories_intros.map do |category|
             
              courses_intros =Udemy::CourseMapper.new(App.config.UDEMY_TOKEN).find('subcategory', category.to_hash[:name])
              # Add project to database
              courses_intros.map do |course_intro|
                Repository::For.entity(course_intro).create(course_intro)
              end
             
            end 
            

            view 'introhobby', locals: { courses: courses_intros,hoppy:hobby_intro,categories:categories_intros }
          end
        end
      end

      routing.on 'test_2' do
        routing.is do
          routing.post do
            view 'test_2'
          end
        end
      end
      
      routing.on 'test_3' do
        routing.is do
          routing.post do
            view 'test_3'
          end
        end
      end
      
      routing.on 'test_4' do
        routing.is do
          routing.post do
            view 'test_4'
          end
        end
      end
    end
  end
end
