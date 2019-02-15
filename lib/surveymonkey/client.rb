require 'httparty'
require_relative 'client/users'
require_relative 'client/surveys'
require_relative 'client/page'
require_relative 'client/responses'
require_relative 'client/question'

module SurveyMonkeyApi
    # Client class for api requests
    class Client
        include HTTParty
        include SurveyMonkeyApi::Client::Users
        include SurveyMonkeyApi::Client::Surveys
        include SurveyMonkeyApi::Client::SurveyResponses

        base_uri 'https://api.surveymonkey.net'
        format :json
        attr_accessor :access_token

        def initialize(_args = {})
          @_pages = {}
          access_token = ENV['SURVEY_MONKEY_TOKEN']
          self.class.default_options.merge!(headers:
                                              { 'Authorization' => "Bearer #{access_token}",
                                                'Content-Type' => 'application/json' }
                                           )
          @api_limits = {}
        end

        def base_request(method, uri, query: )
          response = self.class.send(method, uri, query: query)
          @api_limits[:minute] = response.headers['x-ratelimit-app-global-minute-remaining']
          @api_limits[:day] = response.headers['x-ratelimit-app-global-day-remaining']
          response.parsed_response
        end

        def api_limit_minute
          @api_limits[:minute]
        end

        def api_limit_day
          @api_limits[:day]
        end

        def token=(token)
          @access_token = token
          self.class.default_options.merge!(headers: { 'Authorization' => "Bearer #{token}", })
        end

        def token
          access_token
        end
    end
end
