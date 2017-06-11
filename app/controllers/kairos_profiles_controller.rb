class KairosProfilesController < ApplicationController
  # before_filter :find_model

  def create
    begin
      # Should pass instance of service not just params
      current_user.kairos_profile.create!(params)
      render json: {status: 200, message: 'Kairos Profile Created!'}
    rescue Exception => e
      render json: {
        status: 500,
        error: {
          message: "#{e.message}"
        }
      }
    end
  end

  def destroy
    current_user.kairos_profile.destroy

    render json: {status: 200, message: 'Kairos Profile Destroyed!'}
  end

  private
  def find_model
    @model = KairosProfile.find(params[:id]) if params[:id]
  end
end
