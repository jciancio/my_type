class UsersController < ApplicationController
  before_action :find_user, except: [:index, :create]

  def index
    @users = UserLikeSorter.new(current_user).score_users

    render_response(data: @users)
  end

  def show
    begin
      @response = { user: @user }

      if current_user.likes.include? @user
        reaction = current_user.user_likes.where(like_id: @user.id).first.reaction_datum
        @response.merge!({
          reaction_data: reaction,
          analysis: reaction.analyze
        })
      end

      render_response(data: @response)
    rescue Exception => e
      render_response(error: e)
    end
  end

  def create
    begin
      @user = User.create!(user_params)
      render_response(data: @user)
    rescue Exception => e
      render_response(error: e)
    end
  end

  private
  def find_user
    @user = User.find(params[:id]) if params[:id]
  end

  def user_params
    params.require(:user).permit(:name, :gender, :email)
  end
end
