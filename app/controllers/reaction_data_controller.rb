class ReactionDataController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user
  before_action :set_user_like

  def index
    @reaction_datum = @user_like.reaction_datum

    respond_with do |format|
      format.json render { json: @reaction_datum }
    end
  end

  def create
    begin
      @reaction_data = @user_like.reaction_datum.create!

      @response = {
        status: 200,
        message: 'Reaction Data Saved!'
        data: {
          @reaction_data.to_json
        }
      }
    rescue Exception => e
      @response = {
        status: 500,
        error: {
          message: "#{'*' * 100} #{e.message} #{'*' * 100}"
        }
      }
    end

    respond_with do |format|
      format.json { json: @response }
    end
  end

  private
  def set_user_like
    @user_like = UserLike.find(params[:user_like_id])
  end
end
