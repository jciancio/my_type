class SessionsController < ApplicationController
  skip_before_action :current_user
  skip_before_action :authenticate_user

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      render_response(data: {user_id: @user.id}, message: 'Logged In!')
    else
      render_response(error: Exception.new, message: 'Unable to login', status: 401)
    end
  end
end
