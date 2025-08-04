# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    name { 'Test User' }
    role { 'student' }

    trait :admin do
      role { 'admin' }
    end

    trait :teacher do
      role { 'teacher' }
    end
  end
end
