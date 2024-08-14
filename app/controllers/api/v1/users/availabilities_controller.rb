module Api::V1::Users
  class AvailabilitiesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    # GET api/v1/users/:user_id/monitoring_requests
    def index
      date = params[:date] ? Date.parse(params[:date]) : Date.today
      @availabilities = @user.availabilities.by_week(date)
      @availabilities_by_day = @availabilities.group_by { |availability| availability.start_time.strftime("%A") }
      render json: {
        availabilities: @availabilities,
        availabilities_by_day: @availabilities_by_day
      }
    end

    def create
      @availability = Availability.new(availability_params)
      @availability.user = @user
      @availability.set_end_time

      if @availability.save
        render json: @availability, status: :created
      else
        render json: @availability.errors, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def availability_params
      params.require(:availability).permit(:start_time)
    end
  end
end