RSpec.describe SurveyMonkeyApi::Question do
  before do
  end

  it 'can be initialized with a hash' do
    q = SurveyMonkeyApi::Question.new
    q.with_hash({'family' => 'single_choice', 'answers' => {'choices' => [{'id' => 1, 'text' => 'Yes'}]} })
    expect(q.single_choice_responses.size).to eq(1)
  end
end
