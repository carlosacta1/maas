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
    # jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, ENV['JWT_SECRET_KEY']).first
    # current_user = User.find(jwt_payload['sub'])

    # if current_user
    #   render json: {
    #     status: 200,
    #     message: 'Logged out successfully.',
    #   }, status: :ok
    # else
    #   render json: {
    #     status: 401,
    #     message: 'User has no active session.',
    #   }, status: :unauthorized
    # end
    # 
    
    render json: {
      status: 200,
      message: 'Logged out successfully.',
    }, status: :ok
  end
end
