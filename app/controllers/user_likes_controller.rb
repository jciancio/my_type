class UserLikesController < ApplicationController
  def index
    begin
      render json: {
        status: 200,
        data: {
          user_likes: current_user.likes,
          likes_user: UserLike.where(like_id: current_user.id).map(&:user)
        }
      }
    rescue Exception => e
      render json: {
        status: 500,
        error: {
          message: "#{e.message}"
        }
      }
    end
  end

  def create
    begin
      like = User.find(params[:like_id])
      @user_like = UserLike.create!(user_id: current_user.id, like_id: like.id)
      @response = {
        status: 200,
        message: 'User Like Added!',
        data: @user_like
      }
    rescue Exception => e
      @response = {
        status: 500,
        error: {
          message: "#{'*' * 100} #{e.message} #{'*' * 100}",
          backtrace: "#{e.backtrace}"
        }
      }
    end

    render json: @response
  end

  def destroy
    user_like = UserLike.where(like_id: params[:like_id], user_id: current_user.id).first
    user_like.destroy

    render json: { status: 200, message: 'User like destroyed!' }
  end
end
