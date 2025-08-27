FactoryBot.define do
  factory :homework do
    title { 'MyString' }
    description { 'MyText' }
    deadline { '2025-08-27' }
    assignment { nil }
  end
end
