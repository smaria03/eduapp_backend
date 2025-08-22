FactoryBot.define do
  factory :quiz_answer do
    quiz_submission { nil }
    quiz_question { nil }
    selected_option_ids { 1 }
    array { '' }
    default { '' }
  end
end
