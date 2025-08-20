FactoryBot.define do
  factory :timetable_entry do
    association :assignment, factory: :school_class_subject
    association :period
    weekday { :monday }
  end
end
