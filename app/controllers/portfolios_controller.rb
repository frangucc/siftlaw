class PortfoliosController < ApplicationController
  def create
    @portfolio = Portfolio.create(params[:portfolio])
    @errors = @portfolio.errors.full_messages
    respond_to do |format|
      format.js
      format.html {redirect_to portfolio_company_path(current_user.company)}
    end
  end
  
  def destroy
    @portfolio = Portfolio.find params[:id]
    @portfolio.destroy
    redirect_to portfolio_company_path
  end
end
