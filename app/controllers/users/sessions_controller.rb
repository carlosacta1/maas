# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: :ok,
      data: {
        code: 200, 
        message: 'Logged in successfully.', 
        user: resource
      }
    }
  end

  def respond_to_on_destroy
    render json: {
      status: 200,
      message: 'Logged out successfully.',
    }, status: :ok
  end
end
