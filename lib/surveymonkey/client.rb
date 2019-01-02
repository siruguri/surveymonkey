require 'httparty'
require_relative 'client/users'
require_relative 'client/surveys'
require_relative 'client/responses'

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
          access_token = ENV['SURVEY_MONKEY_TOKEN']
          self.class.default_options.merge!(headers:
                                              { 'Authorization' => "Bearer #{access_token}",
                                                'Content-Type' => 'application/json' }
                                           )
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
