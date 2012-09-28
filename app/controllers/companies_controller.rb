class CompaniesController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create, :show]
  
  def create
    @company = Company.new(params[:company])
    @portfolio_id = params[:portfolio_id]
    if params[:step] == '1'
      @step = '2'
      render :new
    else
      @user = User.new(params[:user])
      if @user.save
        @company.user = @user
        @company.save
        unless @portfolio_id.blank?
          portfolio = Portfolio.find(@portfolio_id)
          @company.portfolios << portfolio
        end
        sign_in(:user, @user)
        redirect_to root_path
      else
        @step = '2'
        @errors = @user.errors.full_messages
        render :new
      end
    end
  end
  
  def favorite
    @company = Company.find params[:id]
    current_user.favorites.create(company_id: @company.id)
    redirect_to favorites_path
  end
  
  def new
    @step = '1'
    @company = Company.new
  end
  
  def profile
    @company = current_user.company || Company.find(params[:id])
  end
  
  def show
    @company = Company.find(params[:id])
    @filter_nav = true
  end
  
  def update
    @company = current_user.company || Company.find(params[:id])
    if @company.update_attributes(params[:company])
      redirect_to profile_company_path(@company)
      flash[:notice] = "updated company profile successfully"
    else
      @errors = @company.errors.full_messages
      render :profile
    end
  end
  
end
