class HomeController < ApplicationController
  def index
    @pro_listings = Company.all
    @free_listings = Company.all
    @filter_nav = true
  end
end
