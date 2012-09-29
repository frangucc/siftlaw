class PortfoliosController < ApplicationController
  def create
    @portfolio = Portfolio.create(params[:portfolio])
    @errors = @portfolio.errors.full_messages
    respond_to :js
  end
  
  def destroy
    @portfolio = Portfolio.find params[:id]
    @portfolio.destroy
    redirect_to portfolio_company_path
  end
end
