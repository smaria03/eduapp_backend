FactoryBot.define do
  factory :school_class do
    sequence(:name) { |n| "#{(n % 12) + 1}#{('A'..'G').to_a[n % 7]}" }
  end
end
