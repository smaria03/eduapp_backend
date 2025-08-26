FactoryBot.define do
  factory :quiz_submission, class: 'Quiz::QuizSubmission' do
    association :quiz, factory: :quiz
    association :student, factory: :user
    submitted_at { Time.current }
    raw_score { 1.5 }
    final_score { 1.5 }
  end
end
