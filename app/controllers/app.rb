# frozen_string_literal: true

require 'roda'
require 'slim'
require 'yaml'

module HobbyCatcher
  # Web App
  class App < Roda
    # plugin :halt
    # plugin :flash
    # plugin :all_verbs # recognizes HTTP verbs beyond GET/POST (e.g., DELETE)
    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :public, root: 'app/presentation/public'
    plugin :assets, path: 'app/presentation/assets',
                    css: 'style.css', js: 'table_row.js'
    # rubocop:disable Metrics/BlockLength
    route do |routing|
      routing.assets # load CSS
      routing.public

      # GET /
      routing.root do
        view_courses = Repository::For.klass(Entity::Course).all
        view 'home', locals: { view_courses: view_courses }
      end

      routing.on 'test' do
        routing.is do
          routing.post do
            questions = Repository::Questions.all
            view 'test', locals: {questions: questions}
          end
        end
      end

      routing.on 'suggestion' do
        routing.is do
          # POST /introhobby/
          routing.post do
            type      = routing.params['type'].to_i
            difficulty = routing.params['difficulty'].to_i
            freetime  = routing.params['freetime'].to_i
            emotion   = routing.params['emotion'].to_i
            answer = [type, difficulty, freetime, emotion]
            #有需要refactor嗎
            binding.pry
            hobby = Mapper::HobbySuggestions.new(answer).build_entity
            # Redirect viewer to project page
            routing.redirect "suggestion/#{hobby.answers.id}"
          end
        end

        routing.on String do |hobby_id|
          # GET /introhoppy/hoppy
          routing.get do
            hobby = HobbyCatcher::Database::HobbyOrm.where(id: hobby_id).first
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
            #view 'introhobby', locals: { courses: courses_intros.flatten, hobby: hobby, categories: categories }
            view 'suggestion', locals: { courses: courses_intros.flatten, hobby: hobby, categories: categories }
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
