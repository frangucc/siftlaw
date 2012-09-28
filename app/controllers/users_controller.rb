class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:delete_favorites]
  def delete_favorites
    current_user.favorites.delete_all
    redirect_to root_path
  end
  
  def new
    @user = User.new
  end
  
end
