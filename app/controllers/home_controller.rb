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
    listings = Company.where(query_hash)
    @pro_listings = listings.select{|com| com.pro==true}
    @free_listings = listings.select{|com| com.pro.blank? || com.pro==false}
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
