class FavoritesController < ApplicationController
  before_filter :authenticate_user!
   
  def index
    @favorites = current_user.favorites
    @companies = @favorites.map(&:company)
    @categories = @companies.map(&:primary_category).uniq
    @filter_nav = true
  end
  
end
