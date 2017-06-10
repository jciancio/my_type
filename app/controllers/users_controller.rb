class UsersController < ApplicationController
  # before_action :find_user, except: :index

  def index
    @users = User.all

    render json: @users
  end

  def create
    begin
      @user = User.create!(user_params)
      @response = {
        status: 200,
        data: {
          user: @user
        }
      }
    rescue Exception => e
      @response = {
        status: 500,
        error: {
          message: "#{e.message}"
        }
      }
    end

    render json: @response
  end

  private
  def find_user
    @user = Users.find(params[:id]) if params[:id]
  end

  def user_params
    params.require(:user).permit(:name, :gender, :email)
  end
end
