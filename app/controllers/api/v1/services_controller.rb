module Api::V1
  class ServicesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_service, only: %i[ show update destroy ]

    # GET api/v1/services
    def index
      @services = Service.all

      render json: @services
    end

    # GET api/v1/services/1
    def show
      weeks = @service.generate_monitoring_weeks
      render json: {
        service: @service,
        weeks: weeks
      }
    end

    # POST api/v1/services
    def create
      @service = Service.new(service_params)

      if @service.save
        render json: @service, status: :created
      else
        render json: @service.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/v1/services/1
    def update
      if @service.update(service_params)
        render json: @service
      else
        render json: @service.errors, status: :unprocessable_entity
      end
    end

    # DELETE api/v1/services/1
    def destroy
      @service.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_service
        @service = Service.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def service_params
        params.require(:service).permit(:name, :description)
      end
  end
end