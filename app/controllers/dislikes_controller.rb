class DislikesController < ApplicationController
  def create
    dislike = User.find(params[:dislike_id])
    @user_dislike = Dislike.create!(user_id: current_user.id, dislike_id: dislike.id)
    render_response(data: @user_dislike, message: 'User Disliked!')
  end
end
