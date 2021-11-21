# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'
require 'yaml'

module HobbyCatcher
  # Web App
  class App < Roda
    plugin :halt
    plugin :flash
    plugin :all_verbs # recognizes HTTP verbs beyond GET/POST (e.g., DELETE)
    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :public, root: 'app/presentation/public'
    plugin :assets, path: 'app/presentation/assets',
                    css: 'style.css', js: 'table_row.js'

    use Rack::MethodOverride # for other HTTP verbs (with plugin all_verbs

    # rubocop:disable Metrics/BlockLength
    route do |routing|
      routing.assets # load CSS
      routing.public

      # GET /
      routing.root do
        # Get cookie viewer's previously seen test history
        session[:watching] ||= []

        hobbies = session[:watching].map do |history|
          history
        end
        
        view 'home', locals: {hobbies: hobbies}
      end

      routing.on 'test' do
        routing.is do
          routing.post do
            questions = Repository::Questions.all
            view 'test', locals: {questions: questions}
          rescue StandardError => e
            flash.now[:error] = 'Having trouble accessing the question database'
            puts e.message
  
            routing.redirect '/'
          end
        end
      end

      routing.on 'history_test' do
        routing.post do
          hobby = routing.params['delete']
          delete_item = nil
          session[:watching].each do |item|
            delete_item = item if item.updated_at.to_s == hobby
          end
          session[:watching].delete(delete_item)

          routing.redirect '/history_test'
        end

        routing.is do
          routing.get do
            # Load previously viewed hobbies
            hobbies = session[:watching].map do |history|
              history
            end
            
            if hobbies.nil?
              flash.now[:notice] = 'Catch your hobby first to see history.'
              routing.redirect '/'
            end
            
            view 'history_test', locals: {hobbies: hobbies}
          end          
        end
      end

      routing.on 'suggestion' do
        routing.is do
          # POST /introhobby/
          routing.post do
            type       = routing.params['type'].to_i
            difficulty = routing.params['difficulty'].to_i
            freetime   = routing.params['freetime'].to_i
            emotion    = routing.params['emotion'].to_i
            answer = [type, difficulty, freetime, emotion]
            # 有需要refactor嗎
            # if type.nil? || difficulty.nil? || freetime.nil? || emotion.nil?
            if type==0 || difficulty==0 || freetime==0 || emotion==0
              flash[:error] = 'Seems like you did not answer all of the questions'
              routing.redirect '/test'
            end
            hobby = Mapper::HobbySuggestions.new(answer).build_entity
            # Add new record to watched set in cookies
            session[:watching].insert(0, hobby.answers).uniq!
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
            view 'suggestion', locals: { courses: courses_intros.flatten, hobby: hobby, categories: categories }
          rescue StandardError => e
            flash.now[:error] = 'Having trouble accessing Udemy courses'
            puts e.message

            routing.redirect '/'
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
