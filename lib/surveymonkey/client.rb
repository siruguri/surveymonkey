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

        base_uri 'https://api.surveymonkey.com'
        format :json
        class << self
          attr_reader :access_token
          def token=(token)
            @access_token = token
            h = default_options[:headers].merge({ 'Authorization' => "Bearer #{token}" })
            default_options.merge!({headers: h})
          end
        end

        def initialize
          @_pages = {}
          self.class.default_options.merge!(headers:
                                              { 'Authorization' => "Bearer #{SurveyMonkeyApi::Client.access_token}",
                                                'Content-Type' => 'application/json' }
                                           )
          @api_limits = {}
        end

        def base_request(method, uri, query: , query_type: :query)
          response = if query_type == :query
                       self.class.send(method, uri, query: query)
                     else
                       self.class.send(method, uri, body: query.to_json)
                     end
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
    end
end
