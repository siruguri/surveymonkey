module SurveyMonkeyApi
    class Client
        # API endpoints for surveys resources
      class Page
        attr_reader :page_id, :survey_id
        def initialize(survey_id, id)
          @page_id = id
          @survey_id = survey_id
        end

        def questions(options = {})
          response = self.class.get("/v3/surveys/#{survey_id}/pages/#{page_id}/question", query: options)
          response.parsed_response
        end
      end
    end
end
