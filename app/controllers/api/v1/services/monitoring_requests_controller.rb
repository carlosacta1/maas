module Api::V1::Services
  class MonitoringRequestsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_service

    # GET api/v1/services/:service_id/monitoring_requests
    def index
      date = params[:date] ? Date.parse(params[:date]) : Date.today
      @monitoring_requests = @service.monitoring_requests.by_week(date).order(:start_time)
      @monitoring_requests_by_day = @monitoring_requests.group_by { |monitoring_request| monitoring_request.start_time.strftime("%A") }
      render json: {
        monitoring_requests: @monitoring_requests,
        monitoring_requests_by_day: @monitoring_requests_by_day
      }
    end

    def create
      @monitoring_request = MonitoringRequest.new(monitoring_request_params)
      @monitoring_request.service = @service
      @monitoring_request.set_end_time

      if @monitoring_request.save
        render json: @monitoring_request, status: :created
      else
        render json: @monitoring_request.errors, status: :unprocessable_entity
      end
    end

    private

    def set_service
      @service = Service.find(params[:service_id])
    end

    def monitoring_request_params
      params.require(:monitoring_request).permit(:start_time)
    end
  end
end