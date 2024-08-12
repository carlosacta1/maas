module Api::V1
  class ServiceUserMonitorsController < ApplicationController
    before_action :authorize_access_request!
    before_action :set_service_user_monitor, only: %i[ show update destroy ]

    # GET api/service_user_monitors
    def index
      @service_user_monitors = ServiceUserMonitor.all

      render json: @service_user_monitors
    end

    # GET api/v1/service_user_monitors/1
    def show
      render json: @service_user_monitor
    end

    # POST api/v1/service_user_monitors
    def create
      @service_user_monitor = ServiceUserMonitor.new(service_user_monitor_params)

      if @service_user_monitor.save
        render json: @service_user_monitor, status: :created, location: @service_user_monitor
      else
        render json: @service_user_monitor.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/v1/service_user_monitors/1
    def update
      if @service_user_monitor.update(service_user_monitor_params)
        render json: @service_user_monitor
      else
        render json: @service_user_monitor.errors, status: :unprocessable_entity
      end
    end

    # DELETE api/v1/service_user_monitors/1
    def destroy
      @service_user_monitor.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_service_user_monitor
        @service_user_monitor = ServiceUserMonitor.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def service_user_monitor_params
        params.require(:service_user_monitor).permit(:service_id, :user_id, :schedule)
      end
  end
end