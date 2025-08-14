FactoryBot.define do
  factory :grade do
    value { rand(1..10) }
    association :student, factory: %i[user student]
    association :teacher, factory: %i[user teacher]
    subject
  end
end
