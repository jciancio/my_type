class StocksController < ApplicationController
  def index
    render_response(data: Stock.all)
  end
end
