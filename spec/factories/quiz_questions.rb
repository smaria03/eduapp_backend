FactoryBot.define do
  factory :quiz_question, class: 'Quiz::QuizQuestion' do
    question_text { 'Example question' }
    point_value { 2 }
    association :quiz, factory: :quiz
  end
end
