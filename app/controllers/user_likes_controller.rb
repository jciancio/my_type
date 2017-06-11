class UserLikesController < ApplicationController
  def index
    begin
      render_response(data: {
        user_likes: current_user.likes.map { |u| u.attributes.merge(image_link: u.kairos_profile.image_url) },
        likes_user: UserLike.where(like_id: current_user.id).map(&:user).map { |u| u.attributes.merge(image_link: u.kairos_profile.image_url) }
      })
    rescue Exception => e
      render_response(error: e)
    end
  end

  def create
    begin
      like = User.find(params[:like_id])
      @user_like = UserLike.create!(user_id: current_user.id, like_id: like.id)
      render_response(data: @user_like, message: 'User Liked!')
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
