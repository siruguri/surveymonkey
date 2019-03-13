RSpec.describe SurveyMonkeyApi::Client do
  before do
    webmock_stubs
  end

  it 'can be initialized with a hash' do
    client = SurveyMonkeyApi::Client.new
    # It will return all the responses that are there which the stub says is 100
    response = client.responses_with_details('surveyid', per_page: 20)
    expect(response['data'].size).to eq(100)
  end
end
