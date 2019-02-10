module SurveyMonkeyApi
    class Question < Client
      attr_reader :question_id, :page_id, :survey_id
      def initialize(id, page_id, survey_id)
        @question_id = id
        @page_id = page_id
        @survey_id = survey_id
      end

      def title
        details unless @details
        @details['headings'].map { |h| h['heading']}.join(', ')
      end

      def single_choice_responses
        details unless @details
        if @details['family'] == 'single_choice'
          @details['answers']['choices'].map do |choice|
            Struct.new(:id, :text).new(choice['id'], choice['text'])
          end
        else
          []
        end
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

