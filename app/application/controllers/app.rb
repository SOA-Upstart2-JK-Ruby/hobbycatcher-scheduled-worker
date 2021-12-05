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
<<<<<<< HEAD
        
=======
        # Get cookie viewer's previously seen test history

>>>>>>> 7282fd30511a2c959280e2456633f42d1ab88c14
        result_response = Representer::HttpResponse.new(
          Response::ApiResult.new(status: :ok, message: message)
        )

        response.status = result_response.http_status_code
        result_response.to_json
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

        # routing.on 'history' do
        #   routing.post do
        #     hobby = routing.params['delete']
        #     delete_item = nil
        #     session[:watching].each do |item|
        #       delete_item = item if item.updated_at.to_s == hobby
        #     end
        #     session[:watching].delete(delete_item)
  
        #     routing.redirect '/history'
        #   end
  
        #   routing.is do
        #     routing.get do
        #       # Load previously viewed hobbies
        #       result = Service::ListHistories.new.call(session[:watching])
  
        #       if result.failure?
        #         flash[:error] = result.failure
        #         viewable_hobbies = []
        #       else
        #         hobbies = result.value!
        #         flash.now[:notice] = 'Catch your hobby first to see history.' if hobbies.empty?
  
        #         viewable_hobbies = Views::HobbiesList.new(hobbies)
        #       end
  
        #       view 'history', locals: { hobbies: viewable_hobbies }
        #     end
        #   end
        # end

        routing.on 'suggestion' do
          routing.is do
            # POST api/v1/suggestion?type=1&difficulty=1&freetime=1&emotion=1
            routing.post do
              url_req = Request::AddAnswer.new(routing.params)
              result = Service::GetAnswer.new.call(url_request: url_req)

              if result.failure?
                failed = Representer::HttpResponse.new(result.failure)
                routing.halt failed.http_status_code, failed.to_json
              end

              http_response = Representer::HttpResponse.new(result.value!)
              response.status = http_response.http_status_code
              Representer::Hobby.new(result.value!.message.answers).to_json
            end
          end

          # GET api/v1/suggestion/{hobby_id}
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
              # 卡在回傳
              Representer::Suggestion.new(result.value!.message[0][0]).to_json
            end
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
