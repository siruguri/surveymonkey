module SurveyMonkeyApi
    class Client
        # API endpoints for surveys resources
        module SurveyResponses
            # Returns list of survey responses for survey
            # Each survey looks like
            # {"href"=>"https://api.surveymonkey.net/v3/surveys/00000001/responses/1234", "id"=>"1234"}
            def responses(survey_id, options = {})
                response = self.class.get("/v3/surveys/#{survey_id}/responses", query: options)
                response.parsed_response
            end

            def responses_with_details(survey_id, options = {})
              url = "/v3/surveys/#{survey_id}/responses/bulk"
              first_response = base_request :get, url, query: options
              
                total = first_response['total']
                per_page = first_response['per_page']

                if total > per_page
                  append_all_pages! first_response, url, per_page, total
                end
                first_response
            end

            # Returns response's information for survey
            def response(survey_id, response_id, options = {})
                response = self.class.get("/v3/surveys/#{survey_id}/responses/#{response_id}", query: options)
                response.parsed_response
            end

            # Returns response's information for survey with details
            def response_with_details(survey_id, response_id, options = {})
                response = self.class.get("/v3/surveys/#{survey_id}/responses/#{response_id}/details", query: options)
                response.parsed_response
            end

            private
            # Return remaining pages in list of responses
            def append_all_pages!(response_hash, url, per_page, total)
              remaining = total - per_page
              page_start = 2
              while remaining > 0
                response = self.class.get(url, query: {per_page: per_page, page: page_start})
                remaining -= per_page
                page_start += 1
                response_hash['data'] += response.parsed_response['data']
              end
            end
        end
    end
end
