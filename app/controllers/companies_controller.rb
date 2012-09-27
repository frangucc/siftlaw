class CompaniesController < ApplicationController
  def new
    @step = '1'
    @company = Company.new
  end
  
  def create
    @company = Company.new(params[:company])
    if params[:step] == '1'
      @step = '2'
      render :new
    else
      @user = User.new(params[:user])
      if @user.save
        @company.user = @user
        @company.save
        sign_in(:user, @user)
        redirect_to root_path
      else
        @step = '2'
        @errors = @user.errors.full_messages
        render :new
      end
    end
  end
  
  def show
    @company = Company.find(params[:id])
    @filter_nav = true
  end
  
end
