module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[ show update destroy ]

    # GET api/v1/users
    def index
      @users = User.all
  
      render json: @users
    end
  
    # GET api/v1/users/1
    def show
      weeks = @user.generate_monitoring_weeks
      availabilities = @user.availabilities
      render json: {
        user: @user,
        weeks:,
        availabilities:
      }
    end
  
    # POST api/v1/users
    def create
      @users = User.new(users_params)
  
      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT api/v1/users/1
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE api/v1/users/1
    def destroy
      @user.destroy
    end
  
    private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:id, :first_name, :last_name, :email, :role)
    end
  end
end