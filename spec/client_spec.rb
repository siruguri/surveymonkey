RSpec.describe SurveyMonkeyApi::Client do
  before do
    @client = SurveyMonkeyApi::Client.new
  end

  it 'allows the token to be set' do
    @client.token = 'thistoken'
    expect(@client.token).to eq('thistoken')
  end
end
