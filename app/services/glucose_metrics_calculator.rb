class GlucoseMetricsCalculator
    def initialize(member)
      @member = member
    end
  
    def metrics_for(period)
      case period
      when :last_7_days
        current_range = range_for_last_7_days
        previous_range = range_for_last_7_days(offset: 7)
      when :month
        current_range = range_for_month(Date.today)
        previous_range = range_for_previous_month(Date.today)
      else
        raise ArgumentError, "Unknown period: #{period}"
      end
  
      current_readings = readings_in_range(current_range)
      previous_readings = readings_in_range(previous_range)
  
      {
        average_glucose: average(current_readings),
        time_above_range: percent_above(current_readings),
        time_below_range: percent_below(current_readings),
        average_glucose_change: change(average(current_readings), average(previous_readings)),
        time_above_range_change: change(percent_above(current_readings), percent_above(previous_readings)),
        time_below_range_change: change(percent_below(current_readings), percent_below(previous_readings))
      }
    end
  
    private
  
    def readings_in_range(range)
      @member.glucose_levels.where(tested_at: range)
    end
  
    def average(readings)
      return 0 if readings.empty?
      readings.sum(:value).to_f / readings.count
    end
  
    def percent_above(readings)
      return 0 if readings.empty?
      (readings.where("value > 180").count.to_f / readings.count * 100).round(2)
    end
  
    def percent_below(readings)
      return 0 if readings.empty?
      (readings.where("value < 70").count.to_f / readings.count * 100).round(2)
    end
  
    def change(current, previous)
      (current - previous).round(2)
    end
  
    def range_for_last_7_days(offset: 0)
      (Time.zone.now.beginning_of_day - offset.days)..(Time.zone.now.end_of_day - offset.days)
    end
  
    def range_for_month(date)
      date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day
    end
  
    def range_for_previous_month(date)
      last_month = date.prev_month
      range_for_month(last_month)
    end
  end