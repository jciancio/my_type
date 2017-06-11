class SessionsController < ApplicationController
  skip_before_action :current_user
  skip_before_action :authenticate_user

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      @response = {
        status: 200,
        message: 'Logged In!',
        data: {
          user_id: @user.id
        }
      }
    else
      @response = {
        status: 401,
        message: "Unable to login"
      }
    end

    render json: @response
  end
end
