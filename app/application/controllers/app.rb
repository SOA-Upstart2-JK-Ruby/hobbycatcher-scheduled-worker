# frozen_string_literal: true

require 'roda'

# :reek:RepeatedConditiona
module HobbyCatcher
  # Web App
  class App < Roda
    plugin :halt
    plugin :flash
    plugin :all_verbs # recognizes HTTP verbs beyond GET/POST (e.g., DELETE)
    use Rack::MethodOverride # for other HTTP verbs (with plugin all_verbs

    # rubocop:disable Metrics/BlockLength
    route do |routing|
      response['Content-Type'] = 'application/json'

      # GET /
      routing.root do
        message = "HobbyCatcher API v1 at /api/v1/ in #{App.environment} mode"
        # Get cookie viewer's previously seen test history
        session[:watching] ||= []
        viewable_hobbies = Views::HobbiesList.new(session[:watching])
        view 'home', locals: { hobbies: viewable_hobbies }
      end
      routing.on 'api/v1' do
        routing.on 'test' do
          routing.is do
            routing.post do
              routing.redirect 'test'
            end
  
            routing.get do
              result = Service::ShowTest.new.call
  
              if result.failure?
                failed = Representer::HttpResponse.new(result.failure)
                routing.halt failed.http_status_code, failed.to_json
              end

              http_response = Representer::HttpResponse.new(result.value!)
              response.status = http_response.http_status_code              
              Representer::Test.new(result.value!.message).to_json
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
                flash.now[:notice] = 'Catch your hobby first to see history.' if hobbies.empty?
  
                viewable_hobbies = Views::HobbiesList.new(hobbies)
              end
  
              view 'history', locals: { hobbies: viewable_hobbies }
            end
          end
        end

        routing.on 'suggestion' do
          routing.is do
            # POST /introhobby/freetime=0 fiffitculty=1
            routing.post do
              url_request = Request::AddAnswer.new(routing.params)
  
              if url_request.failure?
                flash[:error] = 'Seems like you did not answer all of the questions'
                response.status = 400
                routing.redirect '/test'
              end
  
              answer = [url_request[:type], url_request[:difficulty], url_request[:freetime], url_request[:emotion]]
              result = Service::GetAnswer.new.call(answer)
              hobby = result.value!
  
              # Add new record to watched set in cookies
              session[:watching].insert(0, hobby.answers).uniq!
              # Redirect viewer to project page
              routing.redirect "suggestion/#{hobby.answers.id}"
            end
          end
         
          # GET /suggestion/{hobby_id} 一個或是一列
          routing.on String do |hobby_id|
            # GET /introhobby/hobby
            routing.get do
              result = Service::ShowSuggestion.new.call(hobby_id)

              if result.failure?
                failed = Representer::HttpResponse.new(result.failure)
                routing.halt failed.http_status_code, failed.to_json
              end
  
              http_response = Representer::HttpResponse.new(result.value!)
              response.status = http_response.http_status_code
              #卡在回傳
              Representer::Suggestion.new(result.value!.message).to_json
              # viewable_hobby = Views::Suggestion.new(
              #   suggestions[:hobby], suggestions[:categories], suggestions[:courses_intros]
              # )
  
              # view 'suggestion', locals: { hobby: viewable_hobby }
            end
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
