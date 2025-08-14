FactoryBot.define do
  factory :school_class_subject do
    school_class
    subject
    association :teacher, factory: %i[user teacher]
  end
end
