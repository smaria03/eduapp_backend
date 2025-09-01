FactoryBot.define do
  factory :homework do
    title { 'MyString' }
    description { 'MyText' }
    deadline { 3.days.from_now.to_date }
    assignment { nil }
  end
end
