# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'test@user.com' }
    name { 'Test User' }
    password { 'password123' }
    role { 'student' }
  end
end
