module SurveyMonkeyApi
  class Client
    # API endpoints for surveys resources

    module Surveys
      # Returns list of surveys as array in ['data'] field
      # Each survey looks like
      # {"href"=>"https://api.surveymonkey.net/v3/surveys/120053599", "nickname"=>"", "id"=>"120053599", "title"=>"Nyt"}
      def surveys(options = {})
        response = base_request :get, '/v3/surveys', query: options
      end

      # Returns surveys's information
      def survey(survey_id, options = {})
        base_request :get, "/v3/surveys/#{survey_id}", query: options
      end

      # Returns surveys's information with details
      def survey_with_details(survey_id, options = {})
        response = self.class.get("/v3/surveys/#{survey_id}/details", query: options)
        response.parsed_response
      end

      # Adds a response_complete webhook to a survey
      def webhook_response_complete(survey_id, url)
        options = {
          object_type: 'survey',
          object_ids: [survey_id],
          name: "webhook for survey #{survey_id} #{Random.new(1000).rand}",
          event_type: "response_completed",
          subscription_url: url
        }
        base_request :post, "/v3/webhooks", query: options, query_type: :body
      end

      # Returns surveys's pages
      def pages(survey_id, options = {})
        return @_pages[survey_id] if @_pages[survey_id]
        @_pages[survey_id] = []
        response = self.class.get("/v3/surveys/#{survey_id}/pages", query: options)
        response.parsed_response['data'].each do |page_details|
          @_pages[survey_id] << SurveyMonkeyApi::Page.new(survey_id, page_details['id'])
        end
        @_pages[survey_id]
      end            

      def page_ids(survey_id)
        pages(survey_id).map { |p| p.page_id }
      end

      # Returns all of a survey's questions
      def questions(survey_id)
        page_ids(survey_id).map do |page_id|
          Page.new(survey_id, page_id).questions
        end.flatten
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
