module SurveyMonkeyApi
    class Question < Client
      attr_reader :question_id, :page_id, :survey_id
      def initialize(id = nil, page_id = nil, survey_id = nil)
        @question_id = id
        @page_id = page_id
        @survey_id = survey_id
      end

      def with_hash(hash)
        @details = hash
      end

      def to_json
        details unless @details
        @details.to_json
      end
      
      def title
        details unless @details
        @details['headings'].map { |h| h['heading']}.join(', ')
      end

      def id
        details unless @details
        @details['id']
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

