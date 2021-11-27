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
        viewable_hobbies = Views::HobbiesList.new(session[:watching])

        view 'home', locals: { hobbies: viewable_hobbies }
      end

      routing.on 'test' do
        routing.is do
          routing.post do
            routing.redirect 'test'
          end

          routing.get do
            result = Service::ShowTest.new.call

            if result.failure?
              flash[:error] = result.failure
              routing.redirect '/'
            else
              questions = result.value!
            end

            view 'test', locals: { questions: questions }
          end
        end
      end

      routing.on 'history' do
        routing.post do
          hobby = routing.params['delete']
          delete_item = nil
          session[:watching].each do |item|
            delete_item = item if item.updated_at.to_s == hobby
          end
          session[:watching].delete(delete_item)

          routing.redirect '/history'
        end

        routing.is do
          routing.get do
            # Load previously viewed hobbies
            result = Service::ListHistories.new.call(session[:watching])

            if result.failure?
              flash[:error] = result.failure
              viewable_hobbies = []
            else
              hobbies = result.value!
              if hobbies.empty?
                flash.now[:notice] = 'Catch your hobby first to see history.'
              end

              viewable_hobbies = Views::HobbiesList.new(hobbies)
            end

            view 'history', locals: { hobbies: viewable_hobbies }
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

            unless answer.any?(&:zero?) == false
              flash[:error] = 'Seems like you did not answer all of the questions'
              response.status = 400
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
            viewable_hobby = Views::Hobby.new(hobby)
            view 'suggestion', locals: { hobby: viewable_hobby, courses: courses_intros.flatten }
          
          rescue StandardError => e
            flash[:error] = 'Having trouble accessing Udemy courses'
            puts e.message
            routing.redirect '/'
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
