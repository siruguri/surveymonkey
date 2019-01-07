module SurveyMonkeyApi
    class Question < Client
      attr_reader :question_id, :page_id, :survey_id
      def initialize(id, page_id, survey_id)
        @question_id = id
        @page_id = page_id
        @survey_id = survey_id
      end

      def details(options = {})
        unless @details
          response = Client.get("/v3/surveys/#{survey_id}/pages/#{page_id}/questions/#{question_id}", query: options)
          @details = response.parsed_response
        end
        @details
      end
    end
end

