module Api
    class MetricsController < ApplicationController
      def show
        member = Member.find(params[:id])
        period = params[:period]&.to_sym
  
        unless [:last_7_days, :month].include?(period)
          return render json: { error: "Invalid or missing period" }, status: :bad_request
        end
  
        metrics = GlucoseMetricsCalculator.new(member).metrics_for(period)
        render json: metrics
      end
    end
  end