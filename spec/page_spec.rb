RSpec.describe SurveyMonkeyApi::Page do
  before do
    webmock_stubs
    @client = SurveyMonkeyApi::Client.new
  end

  it 'shows pages' do
    @client.token = 'thistoken'
    survey = @client.surveys['data'][0]
    # See WebMock stub
    expect(@client.pages(survey['id']).size).to eq(2)
  end
end
