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
            hobby = HobbyCatcher::Database::HobbyOrm.where(id: hobby).first
            categories = hobby.owned_categories
            courses_intros = []
            categories.map do |category|
              courses = Udemy::CourseMapper.new(App.config.UDEMY_TOKEN).find('subcategory', category.name)
              courses.map do |course_intro|
                course = Repository::For.entity(course_intro)
                course.create(course_intro) if course.find(course_intro).nil?
              end
              courses_intros.append(courses)
            end
            view 'introhobby', locals: { courses: courses_intros.flatten, hobby: hobby, categories: categories }
          end
        end
      end
    end
  end
end
