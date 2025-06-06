FactoryBot.define do
  factory :glucose_level do
    tested_at { 1.hour.ago }
    tz_offset { '-02:00' }
    value { '10' }
  end
end
