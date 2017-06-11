class UserLikesController < ApplicationController
  def index
    begin
      render_response(data: {
        user_likes: current_user.likes,
        likes_user: UserLike.where(like_id: current_user.id).map(&:user)
      })
    rescue Exception => e
      render_response(error: e)
    end
  end

  def create
    begin
      like = User.find(params[:like_id])
      @user_like = UserLike.create!(user_id: current_user.id, like_id: like.id)
      render_json(@user_like, 'User Liked!')
    rescue Exception => e
      render_response(error: e)
    end
  end

  def destroy
    user_like = UserLike.where(like_id: params[:id], user_id: current_user.id).first
    user_like.destroy

    render_response(message: 'User like destroyed!')
  end
end
