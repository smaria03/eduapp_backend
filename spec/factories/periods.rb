FactoryBot.define do
  factory :period do
    start_time { '08:00' }
    end_time   { '08:50' }
    label      { '08:00–08:50' }
  end
end
