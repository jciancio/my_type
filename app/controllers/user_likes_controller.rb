class UserLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user
  respond_to :json

  def index
    user_likes = UserLike.where(user_id: current_user.id).all

    respond_with do |format|
      format.json { render json: user_likes }
    end
  end

  def liked_me
    likes_user = UserLike.where(like_id: current_user.id).all

    respond_with do |format|
      format.json { render json: likes_user }
    end
  end

  def create
    begin
      like = User.find(params[:like_id])
      @user_like = UserLike.create!(user_id: current_user.id, like_id: like.id)
      @response = {
        status: 200,
        message: 'User Like Added!',
        data: @user_like.to_json
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

    respond_with do |format|
      format.json { render json: @response }
    end
  end

  def destroy
    user_like = UserLike.where(like_id: params[:like_id], user_id: current_user.id).first
    user_like.destroy

    respond_with do |format|
      format.json { render json: { status: 200, message: 'User like destroyed!' } }
    end
  end
end
