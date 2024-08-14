module Api::V1::Users
  class MonitoringRequestsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    # GET api/v1/users/:user_id/monitoring_requests
    def index
      date = params[:date] ? Date.parse(params[:date]) : Date.today
      @monitoring_requests = @user.monitoring_requests.by_week(date).order(:start_time)
      @monitoring_requests_by_day = @monitoring_requests.group_by { |monitoring_request| monitoring_request.start_time.strftime("%A") }
      render json: {
        monitoring_requests: @monitoring_requests,
        monitoring_requests_by_day: @monitoring_requests_by_day
      }
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end