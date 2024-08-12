class AuthController < ApplicationController
  before_action :authorize_access_request!

  def verify_token
    render json: { message: 'Authenticated' }, status: :ok
  end
end