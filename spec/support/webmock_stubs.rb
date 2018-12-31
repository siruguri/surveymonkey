def webmock_stubs
  stub_request(:get, "https://api.surveymonkey.net/v3/surveys/1/collectors").
         with(
           headers: {
       	  'Authorization'=>'Bearer',
       	  'Content-Type'=>'application/json'
           }).
         to_return(status: 200, body: collectors_response)
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
