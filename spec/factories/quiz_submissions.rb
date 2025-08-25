FactoryBot.define do
  factory :quiz_submission do
    quiz { nil }
    student { nil }
    submitted_at { '2025-08-22 13:56:31' }
    raw_score { 1.5 }
    final_score { 1.5 }
  end
end
