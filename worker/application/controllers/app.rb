# frozen_string_literal: true

require 'roda'

# :reek:RepeatedConditiona
module HobbyCatcher
  # Web App
  class App < Roda
    plugin :halt
    plugin :caching
    plugin :all_verbs # recognizes HTTP verbs beyond GET/POST (e.g., DELETE)
    use Rack::MethodOverride # for other HTTP verbs (with plugin all_verbs

    # rubocop:disable Metrics/BlockLength
    route do |routing|
      response['Content-Type'] = 'application/json'

      # GET /
      routing.root do
        message = "HobbyCatcher API v1 at /api/v1/ in #{App.environment} mode"
        
        # 存courses
        Service::AddCoursesWorker.new.call

        result_response = Representer::HttpResponse.new(
          Response::ApiResult.new(status: :ok, message: message)
        )

        response.status = result_response.http_status_code
        result_response.to_json
      end


    end
    # rubocop:enable Metrics/BlockLength
  end
end
