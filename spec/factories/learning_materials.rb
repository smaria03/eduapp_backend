FactoryBot.define do
  factory :learning_material do
    title { 'MyString' }
    description { 'MyText' }
    assignment { association :school_class_subject }
  end
end
