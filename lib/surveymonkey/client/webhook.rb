module SurveyMonkeyApi
    class Webhook < Client
      # API endpoints for pages
      include HTTParty
      base_uri 'https://api.surveymonkey.net'
      format :json

      attr_reader :webhooks
      def initialize
        super()
      end

      def delete_webhook(id)
        base_request :delete, "/v3/webhooks/#{id}", query: {}
        self
      end

      def delete_all
        webhooks.each do |webhook|
          delete_webhook webhook.id
        end
      end

      def fetch_all
        response = base_request :get, '/v3/webhooks', query: {}

        @webhooks = response['data'].map do |hook|
          Struct.new(:id, :name, :uri, :object_type, :object_ids).new hook['id'], hook['name']
        end

        @webhooks.each do |webhook|
          response = base_request(:get, "/v3/webhooks/#{webhook.id}", query: {})
          webhook.uri = response['subscription_url']
          webhook.object_type = response['object_type']
          webhook.object_ids = response['object_ids']
        end
        self
      end
    end
end

