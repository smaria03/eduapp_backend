FactoryBot.define do
  factory :school_class do
    sequence(:name) { |_n| "#{rand(1..12)}#{('A'..'G').to_a.sample}" }
  end
end
