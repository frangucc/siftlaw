class HomeController < ApplicationController
  def index
    @pro_listings = Company.pro_listings
    @free_listings = Company.free_listings
    @filter_nav = true
  end
  
  def search
    @city = params[:city]
    @category = params[:category]
    @budget = params[:budget]
    @state = params[:state]
    @pro_listings = Company.where(query_hash)
    @free_listings = Company.where(query_hash)
    @filter_nav = true
  end
  
  private
    
    def query_hash
      query = {}
      query[:city] = @city unless(@city.blank?)
      query[:primary_category] = @category unless(@category.blank?)
      query[:budget] = @budget unless(@budget.blank?)
      query[:state] = @state unless(@state.blank?)
      query
    end
end
