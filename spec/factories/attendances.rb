FactoryBot.define do
  factory :attendance do
    user { nil }
    assignment { nil }
    period { nil }
    date { '2025-08-19' }
    status { 1 }
  end
end
