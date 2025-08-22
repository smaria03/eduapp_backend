FactoryBot.define do
  factory :quiz, class: 'Quiz::Quiz' do
    title { 'MyString' }
    description { 'MyText' }
    deadline { '2025-08-22 13:43:12' }
    time_limit { 1 }
    assignment { nil }
  end
end
