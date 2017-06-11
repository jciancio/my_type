class ImageController < ApplicationController

  def create
    binding.pry
    @image = params[:image_data]
  end

  def display
    render html: '<img src="data:image/jpeg;base64,<%=@image %>">'
  end

end
