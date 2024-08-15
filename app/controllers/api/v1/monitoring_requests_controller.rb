module Api::V1
  class MonitoringRequestsController < ApplicationController
    before_action :authenticate_user!
    
    def assign_users
      asignation = MonitoringRequests::AssignUsers.new
      if asignation.perform
        render json: {
          status: :ok,
          message: "Monitoring requests assigned successfully" 
        }
      else
        render json: { message: "Error assigning monitoring requests" }, status: :unprocessable_entity
      end
    end
  end
end