module SurveyMonkeyApi
    class Client
        # API endpoints for surveys resources
        module Surveys
            # Returns list of surveys as array in ['data'] field
            # Each survey looks like
            # {"href"=>"https://api.surveymonkey.net/v3/surveys/120053599", "nickname"=>"", "id"=>"120053599", "title"=>"Nyt"}
            def surveys(options = {})
                response = self.class.get('/v3/surveys', query: options)
                response.parsed_response
            end

            # Returns surveys's information
            def survey(survey_id, options = {})
                response = self.class.get("/v3/surveys/#{survey_id}", query: options)
                response.parsed_response
            end

            # Returns surveys's information with details
            def survey_with_details(survey_id, options = {})
                response = self.class.get("/v3/surveys/#{survey_id}/details", query: options)
                response.parsed_response
            end

            # Returns surveys's collectors
            def collectors(survey_id, options = {})
                response = self.class.get("/v3/surveys/#{survey_id}/collectors", query: options)
                response.parsed_response
            end            

            # Returns surveys's collector details
            def collector(collector_id, options = {})
                response = self.class.get("/v3/collectors/#{collector_id}", query: options)
                response.parsed_response
            end            
        end
    end
end
