class StocksController < ApplicationController
  def index
    render_response(data: Stock.all, status: 200)
  end
end
