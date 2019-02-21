RSpec.describe SurveyMonkeyApi do
  before do
    webmock_stubs
  end

  it 'has a version number' do
    expect(SurveyMonkeyApi::VERSION).not_to be nil
  end

  it 'can post a webhook' do
    client = SurveyMonkeyApi::Client.new
    client.class.token = 'thistoken'
    expect(client.webhook_response_complete(123, 'http')['event_type']).to eq('response_completed')
  end
end
