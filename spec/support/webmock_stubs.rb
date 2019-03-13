def webmock_stubs
  stub_request(:get, /api.surveymonkey.com.v3.surveys.surveyid.responses.bulk/).
         with(
           headers: {
       	  'Authorization'=>'Bearer',
       	  'Content-Type'=>'application/json'
           }).
         to_return(status: 200, body: bulk_response)
  
  stub_request(:post, "https://api.surveymonkey.com/v3/webhooks").
         with(
           body: "{\"object_type\":\"survey\",\"object_ids\":[123],\"name\":\"webhook for survey 123 0.6535895854646095\",\"event_type\":\"response_completed\",\"subscription_url\":\"http\"}",
           headers: {
       	  'Authorization'=>'Bearer thistoken'
           }).
         to_return(status: 200, body: webhook_body.to_json)

  stub_request(:get, "https://api.surveymonkey.com/v3/surveys/s_1234/pages").
    with(
      headers: {
       	'Authorization'=>'Bearer thistoken'
      }).
    to_return(status: 200, body: pages_response)
  stub_request(:get, "https://api.surveymonkey.com/v3/surveys/1/collectors").
         with(
           headers: {
       	  'Authorization'=>'Bearer thistoken',
       	  'Content-Type'=>'application/json'
           }).
         to_return(status: 200, body: collectors_response)
  stub_request(:get, "https://api.surveymonkey.com/v3/surveys").
         with(
           headers: {
       	     'Authorization'=>'Bearer thistoken',
           }).
         to_return(status: 200, body: surveys_response,
                   headers: {
                     'x-ratelimit-app-global-minute-remaining' => 20,
                     'x-ratelimit-app-global-day-remaining' => 30
                   }
                  )
end

def pages_response
  {"per_page": 50, "total": 100, 
   "data": [{
  "title": "Page Title 1",
  "description": "page 1",
  "position": 1,
  "question_count": 1,
  "id": "page_title_1",
  "href":"http://api.surveymonkey.com/v3/surveys/1234/pages/page_title_1"
            },
{
  "title": "Page Title 2",
  "description": "page 2",
  "position": 1,
  "question_count": 2,
  "id": "page_title_2",
  "href":"http://api.surveymonkey.com/v3/surveys/1234/pages/page_title_2"
            }           ]}.to_json
end

def surveys_response
  {"per_page": 50, "total": 100, 
   "data": [{
  "title": "My Survey",
  "nickname": "",
  "category":"",
  "language": "en",
  "question_count": 10,
  "page_count": 10,
  "date_created": "2015-10-06T12:56:55",
  "date_modified": "2015-10-06T12:56:55",
  "id": "s_1234",
  "href": "https://api.surveymonkey.com/v3/surveys/1234",
  "buttons_text": {
    "done_button": "Done",
    "prev_button": "Prev",
    "exit_button": "Exit",
    "next_button": "Next"
  },
  "custom_variables": {
    "name": "label"
  },
  "footer": true,
  "folder_id":"1234",
  "preview": "https://www.surveymonkey.com/r/Preview/",
  "edit_url": "https://www.surveymonkey.com/create/",
  "collect_url": "https://www.surveymonkey.com/collect/list",
  "analyze_url": "https://www.surveymonkey.com/analyze/",
  "summary_url": "https://www.surveymonkey.com/summary/"
}]}.to_json
end

def collectors_response
  # From https://developer.surveymonkey.com/api/v3/#surveys-id-collectors
  {
  "status" => "open",
  "id" => "1234",
  "type" => "weblink",
  "name" => "My Collector",
  "thank_you_message" => "Thank you for taking my survey.",
  "disqualification_message" => "Thank you for taking my survey.",
  "close_date" => "2038-01-01T00:00:00+00:00",
  "closed_page_message" => "This survey is currently closed.",
  "redirect_url" => "https://www.surveymonkey.com",
  "display_survey_results" => false,
  "edit_response_type" => "until_complete",
  "anonymous_type" => "not_anonymous",
  "allow_multiple_responses" => false,
  "date_modified" => "2015-10-06T12:56:55+00:00",
  "url" => "https://www.surveymonkey.com/r/2Q3RXZB",
  "open" => true,
  "date_created" => "2015-10-06T12:56:55+00:00",
  "password_enabled" => false,
  "sender_email" => nil,
  "response_limit" => nil,
  "redirect_type" => "url",
  "href": "https://api.surveymonkey.com/v3/collectors/1234"
  }.to_json
end

def webhook_body
  {
  "id" => "1234",
  "name" => "My Webhook",
  "event_type" => "response_completed",
  "object_type" => "survey",
  "object_ids" => ["1234", "5678"],
  "subscription_url" => "https://surveymonkey.com/webhook_reciever",
  "href" => "https://api.surveymonkey.com/v3/webhooks/123"
  }
end

def bulk_response
  {
    "per_page" => 20,
    "total" => 100,
    "data" => 20.times.map { |m| response },
    "page" => 1,
    "links" => {
      "self" => "https://api.surveymonkey.com/v3/surveys/123456/responses/bulk?page=1&per_page=2"
    }
  }.to_json
end

def response
  {
    "total_time" => 0,
    "collection_mode" => "default",
    "href" => "https://api.surveymonkey.com/v3/responses/5007154325",
  }
end
