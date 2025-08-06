FactoryBot.define do
  factory :subject do
    name { Faker::Alphanumeric.alpha(number: 8) }
  end
end
