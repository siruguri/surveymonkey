module SurveyMonkeyApi
    class Page < Client
      # API endpoints for pages
      include HTTParty
      base_uri 'https://api.surveymonkey.net'
      format :json
      attr_reader :page_id, :survey_id

      def initialize(survey_id, id)
        super()
        @page_id = id
        @survey_id = survey_id
      end

      def questions(options = {})
        if @_questions.nil?
          @_questions = []
          response = base_request :get, "/v3/surveys/#{survey_id}/pages/#{page_id}/questions", query: options
          response['data'].each do |question_details|
            @_questions << SurveyMonkeyApi::Question.new(question_details['id'], page_id, survey_id)
          end
        end
        @_questions
      end
    end
end

