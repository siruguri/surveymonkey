RSpec.describe SurveyMonkeyApi::Client do
  before do
    @client = SurveyMonkeyApi::Client.new
    webmock_stubs
  end

  it 'allows the token to be set' do
    expect(SurveyMonkeyApi::Client.token = 'hello').to eq('hello')
    @client.class.token = 'thistoken'
    expect(@client.class.access_token).to eq('thistoken')
  end

  it 'shows api limit information' do
    @client.surveys
    expect(@client.api_limit_minute).to eq('20')
  end
end
