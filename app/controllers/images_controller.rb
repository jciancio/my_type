class ImagesController < ApplicationController

  def create
    binding.pry
    kairos_profile = KairosProfile.new(user: current_user, image_url: params[:image_data])
    if kairos_profile.save
      render json: {
        status: 201,
        message: "Picture successfully uploaded!"
      }
    else
      render json: {
        status: 400,
        error: {
          message: "Upload Failed!"
        }
      }
    end
  end

end
