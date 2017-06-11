class StocksController < ApplicationController
  def index
    stocks = Stock.all
    render_response(data: stocks.map { |u| u.attributes.merge(image_link: u.kairos_profile.image_url) }, status: 200)
  end
end
