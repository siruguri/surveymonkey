RSpec.describe SurveyMonkeyApi::Client::Surveys do
  before do
    webmock_stubs
    @client = SurveyMonkeyApi::Client.new
  end

  it 'responds to collectors' do
    expect(@client.collectors(1)).not_to be nil
  end
end
