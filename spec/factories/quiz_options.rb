FactoryBot.define do
  factory :quiz_option, class: 'Quiz::QuizOption' do
    text { 'Option A' }
    is_correct { false }
    association :question, factory: :quiz_question
  end
end
