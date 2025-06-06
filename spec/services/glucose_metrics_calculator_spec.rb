require 'rails_helper'

RSpec.describe GlucoseMetricsCalculator, type: :service do
  let(:member) { Member.create!(name: "Test Member") }

  before do
    # Current 7 days
    3.times { |i| member.glucose_levels.create!(value: 190, tested_at: Time.zone.now - i.days, tz_offset: "-0400") }
    2.times { |i| member.glucose_levels.create!(value: 65, tested_at: Time.zone.now - i.days, tz_offset: "-0400") }
    5.times { |i| member.glucose_levels.create!(value: 110, tested_at: Time.zone.now - i.days, tz_offset: "-0400") }

    # Previous 7 days
    2.times { |i| member.glucose_levels.create!(value: 200, tested_at: Time.zone.now - 8.days - i.days, tz_offset: "-0400") }
    2.times { |i| member.glucose_levels.create!(value: 60, tested_at: Time.zone.now - 8.days - i.days, tz_offset: "-0400") }
    4.times { |i| member.glucose_levels.create!(value: 100, tested_at: Time.zone.now - 8.days - i.days, tz_offset: "-0400") }
  end

  it "calculates metrics for the last 7 days" do
    metrics = GlucoseMetricsCalculator.new(member).metrics_for(:last_7_days)

    expect(metrics[:average_glucose].round(2)).to eq(121.67)
    expect(metrics[:time_above_range]).to eq(33.33)
    expect(metrics[:time_below_range]).to eq(33.33)
    expect(metrics[:average_glucose_change]).to eq(121.67)
    expect(metrics[:time_above_range_change]).to eq(33.33)
    expect(metrics[:time_below_range_change]).to eq(33.33)
  end
end  