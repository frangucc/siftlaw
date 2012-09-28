class PortfoliosController < ApplicationController
  def create
    @portfolio = Portfolio.create(params[:portfolio])
    @errors = @portfolio.errors.full_messages
    respond_to :js
  end
end
