module SurveyMonkeyApi
    class Page < Client
      # API endpoints for pages
      attr_reader :page_id, :survey_id
      
      def initialize(survey_id, id)
        @page_id = id
        @survey_id = survey_id
      end

      def questions(options = {})
        if @_questions.nil?
          @_questions = []

          response = Client.get("/v3/surveys/#{survey_id}/pages/#{page_id}/questions", query: options)
          response.parsed_response['data'].each do |question_details|
            @_questions << SurveyMonkeyApi::Question.new(question_details['id'], page_id, survey_id)
          end
        end
        @_questions
      end
    end
end

