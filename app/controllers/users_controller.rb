class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:delete_favorites]
  def delete_favorites
    current_user.favorites.delete_all
    redirect_to root_path
  end
  
  def new
    @user = User.new
  end
  
  def update
    @user = current_user
    @errors = []
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation) 
    end
    if @user.update_attributes(params[:user])
      sign_in(@user)
      flash[:notice] = 'Successful update account'
      redirect_to account_companies_path
    else
      @errors = @user.errors.full_messages
      render account_companies_path
    end
  end
end
