class ReactionDataController < ApplicationController
  before_action :set_user_like

  def index
    @reaction_datum = @user_like.reaction_datum

    render_response(data: @reaction_datum)
  end

  def create
    begin
      reaction_data = Moment.post_emotions(params[:pic_url])
      reaction_datum = ReactionDatumParser.new(reaction_data[:frames]).prepare

      @reaction_datum = ReactionDatum.create!(reaction_datum.merge(user_like: @user_like))
      render_response(data: @reaction_datum, message: 'Reaction Data Saved!')
    rescue Exception => e
      render_error_from(error: e)
    end
  end

  private
  def set_user_like
    @user_like = UserLike.find(params[:user_like_id])
  end
end
