RSpec.describe SurveyMonkeyApi::Client::Surveys do
  before do
    @client = SurveyMonkeyApi::Client.new
  end

  it 'responds to collector' do
    expect(@client.collectors(1)).not_to be nil
  end
end
